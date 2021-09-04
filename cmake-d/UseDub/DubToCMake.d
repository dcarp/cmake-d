import std.algorithm;
import std.file;
import std.getopt;
import std.json;
import std.stdio;
import std.string;
import std.process;

int main(string[] args)
{
    string cmakeFile = "CMakeLists.txt";
    string dubFile = "";

    getopt(args,
           "package|p", &dubFile,
           "output|o", &cmakeFile);

    if (dubFile != "")
    {
        stderr.writeln("-p is deprecated and does not have any effect anymore. Please keep the default package file name.");
    }

    string json = execute(["dub", "describe"]).output;
    JSONValue dubRoot = parseJSON(json);
    JSONValue root = dubRoot["packages"][0];
    string target = root["targetName"].str;

    string cmake = q"<
cmake_minimum_required(VERSION 2.8)

project(%1$s D)

find_file(APP_MAIN_FILE
    NAMES app.d main.d %1$s/main.d %1$s/app.d
    PATHS source src NO_DEFAULT_PATH)

file(GLOB_RECURSE SRC_FILES source/*.d src/*.d)
if(APP_MAIN_FILE)
    list(REMOVE_ITEM SRC_FILES ${APP_MAIN_FILE})
endif()

include_directories(source src)
>".format(root["name"].str);

    switch ("targetType" in root.object ? root["targetType"].str : "autodetect")
    {
        case "autodetect":
            cmake ~= q"<
if(APP_MAIN_FILE)
    add_executable(%1$s ${SRC_FILES} ${APP_MAIN_FILE})
else()
    add_library(%1$s ${SRC_FILES})
endif()
>".format(target);
            break;
        case "none":
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
            break;
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
            string version_ = "~" ~ dubRoot["packages"].array.find!((obj) => obj["name"] == dependency)[0]["version"].str;
            cmake ~= "DubProject_Add(%s %s)\n".format(dependency, version_);
        }
        cmake ~= "\nadd_dependencies(%s %-(%s %))\n".format(target, root["dependencies"].array);
    }

    std.file.write(cmakeFile, cmake);

    return 0;
}
