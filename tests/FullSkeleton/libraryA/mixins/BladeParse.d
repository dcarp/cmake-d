/** 
 * 
 *  BladeParse
 *
 *  Thanks to the <a href="http://www.dsource.org/projects/mathextra/">mathextra</a> project for this!
 *
 *  Original source <a href="http://www.dsource.org/projects/mathextra/browser/trunk/blade/BladeParse.d">here</a>.
**/

module libraryA.mixins.BladeParse;

// General utilities.
char [] itoa(T)(T x)
{
    char [] s="";
    static if (is(T==byte)||is(T==short)||is(T==int)||is(T==long)) {
        if (x<0) {
            s = "-";
            x = -x;
        }
    }
    do {
        s = cast(char)('0' + (x%10)) ~ s;
        x/=10;
    } while (x>0);
    return s;
}

bool isDigit(char c) { return c>='0' && c<='9'; }
bool isHexDigit(char c) { return c>='0' && c<='9' || c>='a' && c<='f' || c>='A' && c<='F'; }
bool isAlpha(char c) {
    return (c>='a' && c<='z') || (c>='A' && c<='Z');
}
// Underscores allowed
bool isUnderscoreDigit(char c) { return c=='_' || c>='0' && c<='9'; }
bool isUnderscoreHexDigit(char c) { return c=='_' || c>='0' && c<='9' || c>='a' && c<='f' || c>='A' && c<='F'; }
bool isUnderscoreAlpha(char c) {
    return c=='_' || (c>='a' && c<='z') || (c>='A' && c<='Z');
}

unittest {
    assert(isHexDigit('9'));
}

// Extract a D identifier. Return the remainder of the string.
char [] parseIdentifier(char [] s, out char [] rest)
{
    int i=0;
    if (!isUnderscoreAlpha(s[0])) { assert(0, "Identifier expected"); }
    while (i<s.length && (isUnderscoreAlpha(s[i])||isDigit(s[i]))) ++i;
    char [] ident=s[0..i];
    while (i<s.length && s[i]==' ') ++i; // skip trailing spaces
    rest = s[i..$];
    return ident;
}

char [] parseNumber(char [] s, out char[] rest)
{
    int k=0;
    while(k<s.length && isDigit(s[k])) ++k;
    if (k<s.length-1 && s[k]=='.' && s[k+1]!='.') {
        ++k;
        while(k<s.length && isDigit(s[k])) ++k;
        if (k<s.length && s[k]=='e') { ++k;
            if (k<s.length && (s[k]=='+' || s[k]=='-')) ++k;
            while(k<s.length && isDigit(s[k])) ++k;
        }
        if (k<s.length && (s[k]=='L' || s[k]=='f')) ++k;
    }
    char [] ident = s[0..k];
    int i=k;
    while (i<s.length && s[i]==' ') ++i; // skip trailing spaces
    rest = s[i..$];
    return ident;
}

char [] parseOperator(char [] s, out char [] rest)
{
    int i=1;
    if (s[0]=='+' || s[0]=='-' || s[0]=='*') {
        if (s.length>1 && s[1]=='=') ++i;
        int k=i;
        while (k<s.length && s[k]==' ') ++k; // skip trailing spaces
        rest = s[k..$];
        return s[0..i];
    } else {
        assert(0, `Operator expected, not "` ~ s~ `"`);
    }
}

char [] parseQualifiedName(char [] s, out char[] rest)
{
    char [] r;
    char [] id = parseIdentifier(s, r);
    while (r.length>0 && r[0]=='.') {
        int i;
        for (i=1; r[i]==' '; ++i) {}
        id ~= "." ~ parseIdentifier(r[i..$], r);
    }
    rest=r;
    return id;
}


// Some functions to grab information from the typestring.

// Return the first index in the tuple which is of vector type
int findFirstVector(char [][] typelist)
{
    for (int i=0; i< typelist.length;++i) {
        if (isVector(typelist[i])) return i;
    }
    return 0;
}

bool isVector(char [] typestr)
{
    return (typestr[0]=='V' || typestr[0]=='Z');
}

// Count the number of vectors in the typestring
int countVectors(char [][] typelist)
{
    int numVecs=0;
    for (int i=0; i<typelist.length; ++i) {
        if (isVector(typelist[i])) ++numVecs;
    }
    return numVecs;
}

