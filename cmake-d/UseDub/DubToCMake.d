import std.algorithm;
import std.algorithm.searching;
import std.array;
import std.file;
import std.getopt;
import std.json;
import std.path;
import std.process;
import std.stdio;
import std.string;

string cmakeFile = "CMakeLists.txt";
string configuration = "";
string packageName = "";
string subPackage = "";

string[] processedTargets = [];

string[] configurationArg;

int main(string[] args)
{
    getopt(args,
           "package|p", &packageName,
           "configuration|c", &configuration,
           "subpackage|s", &subPackage,
           "output|o", &cmakeFile);

    if (!configuration.empty)
        configurationArg = ["-c", configuration];
    else
        configurationArg = [];

    if (subPackage.canFind(':')) {
        subPackage = ":" ~ subPackage.split(':')[1];
    } else {
        subPackage = "";
    }

    auto packageArgs = [subPackage];

    if (subPackage.canFind(",")) {
        packageArgs = subPackage[1..$].split(',').map!((s) => ":" ~ s).array;
    }

    auto cmake = appender!string();

    cmake ~= format!q"<
# Header
cmake_minimum_required(VERSION 3.18)

project(%s D)

>"(packageName ~ "_proj");

    foreach (pkg; packageArgs) {
        auto packageArg = pkg;

        auto p = pipeProcess(["dub", "describe"] ~ configurationArg ~ packageArg, Redirect.stdout);

        auto apd = appender!string();
        foreach (line; p.stdout.byLine)
        {
            apd ~= line.idup;
        }

        string json = apd[];
        auto dubRoot = parseJSON(json);
        JSONValue root = dubRoot["packages"][0];

        cmake ~= includePackage(dubRoot, root);
    }


    std.file.write(cmakeFile, cmake[]);

    return 0;
}

string includePackage(JSONValue dubRoot, JSONValue root) {
    string target = root["targetName"].str.replace(":", "::");
    string[] tmp = root["name"].str.split(":");
    string subTarget = "";
    if (tmp.length > 1)
        subTarget = tmp[1];

    if (processedTargets.canFind(target))
        return "";

    string cmake = format!"# Section: %s\n"(target);
    bool isInterface = false;

    string normalizedPath(string path) {
        return asNormalizedPath(root["path"].str.asRelativePath(getcwd).array ~ "/" ~ path).array;
    }

    cmake ~= format!"set(SRC_FILES %-(%s %))"(
        root["files"].array.map!(
        (val) {
            if (val["role"].str == "source" || val["role"].str == "import_") {
                string path = normalizedPath(val["path"].str);
                return exists(path) ? path : "";
            }
            else
                return "";
        }).filter!(a => a != "").array
    );

    switch ("targetType" in root.object ? root["targetType"].str : "autodetect")
    {
        case "autodetect":
        cmake ~= q"<
find_file(APP_MAIN_FILE
    NAMES app.d main.d %1$s/main.d %1$s/app.d
    PATHS source src NO_DEFAULT_PATH)

set(SRC_FILES %2$-(%s %))
if(APP_MAIN_FILE)
    list(REMOVE_ITEM SRC_FILES ${APP_MAIN_FILE})
    add_executable(%1$s ${SRC_FILES} ${APP_MAIN_FILE})
else()
    add_library(%1$s ${SRC_FILES})
endif()
>".format(target);
        break;
        case "none":
        cmake ~= q"<
add_library(%s INTERFACE ${SRC_FILES})
>".format(target);
        isInterface = true;
        break;
        case "executable":
        cmake ~= q"<
add_executable(%s ${SRC_FILES} ${APP_MAIN_FILE})
>".format(target);
        break;
        case "library":
        cmake ~= q"<
add_library(%s ${SRC_FILES})
>".format(target);
        break;
        case "sourceLibrary":
        case "staticLibrary":
        cmake ~= q"<
add_library(%s STATIC ${SRC_FILES})
>".format(target);
        break;
        case "dynamicLibrary":
        cmake ~= q"<
add_library(%s SHARED ${SRC_FILES})
>".format(target);
        break;
        default:
        assert(false, "Unknown targetType");
        break;
    }

    cmake ~= q"<
target_include_directories(%s %s %-(%s %))
>".format(target, isInterface ? "INTERFACE" : "PUBLIC", root["importPaths"].array.map!((val) => normalizedPath(val.str)).array ~ (subTarget.empty ? [] : [subTarget]));

    cmake ~= q"<
install(TARGETS %s
    RUNTIME DESTINATION bin
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib)
>".format(target);

    if ("dependencies" in root.object && root["dependencies"].array.length > 0)
    {
        cmake ~= "\ninclude(UseDub)\n";
        foreach (dependency; root["dependencies"].array)
        {
            if (dependency.str.startsWith(dubRoot["rootPackage"].str.split(":")[0])) {
                auto p = pipeProcess(["dub", "describe", dependency.str], Redirect.stdout);

                auto apd = appender!string();
                foreach (line; p.stdout.byLine)
                {
                    apd ~= line.idup;
                }

                auto newDubRoot = parseJSON(apd[]);
                auto pkg = newDubRoot["packages"].array.find!((obj) => obj["name"] == dependency)[0];

                cmake = includePackage(newDubRoot, pkg) ~ cmake;
            } else {
                try {
                    auto pkg = dubRoot["packages"].array.find!((obj) => obj["name"] == dependency)[0];
                    string version_ = pkg["version"].str;
                    cmake ~= "DubProject_Add(%s %s)\n".format(dependency.str, version_);
                } catch (Throwable) {
                    cmake ~= "DubProject_Add(%s)\n".format(dependency.str);
                }
            }
        }

        cmake ~= ("\ntarget_link_libraries(%s " ~ (isInterface ? "INTERFACE" : "PUBLIC") ~ " %-(%s %))\n").format(target, root["dependencies"].array.map!((val) => val.str.replace(":", "::")));
    }

    if ("versions" in root.object && root["versions"].array.length > 0) {
        cmake ~= format!q"<
target_compile_versions(%s PUBLIC %-(%s %))
>"(target, root["versions"].array.map!(a => a.str));
    }

    if ("libs" in root.object && root["libs"].array.length > 0) {
        cmake ~= format!q"<
target_link_libraries(%s PUBLIC %-(%s %))
>"(target, root["libs"].array.map!(a => `"` ~ a.str ~ `"`));
    }

    if ("lflags" in root.object && root["lflags"].array.length > 0) {
        cmake ~= format!q"<
target_link_options(%s PUBLIC "%-(${CMAKE_LINKER_FLAG_PREFIX}%s %)")
>"(target, root["lflags"].array.map!(a => a.str));
    }

    if (target != root["name"].str)
        cmake ~= format!q"<
add_library(%s ALIAS %s)
>"(root["name"].str.replace(":", "::"), target);

    processedTargets ~= target;
    cmake ~= format!"# End section %s \n"(target);

    return cmake;
}
