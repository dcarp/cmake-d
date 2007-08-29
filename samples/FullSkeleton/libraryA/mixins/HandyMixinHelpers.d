/** 
 * 
 *  Handy Mixin Helpers
 *  
 *  Authors: 	Tim Burrell
 *  Copyright: 	Copyright (c) 2007
 *  License:	<a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>
 *
**/

////////////////////////////////////////////////////////////////////////////
// Module
///////////////////////////////////////

module  libraryA.mixins.HandyMixinHelpers;

////////////////////////////////////////////////////////////////////////////
// Imports
///////////////////////////////////////

import	libraryA.mixins.BladeParse;

////////////////////////////////////////////////////////////////////////////
// Mixin Helpers (like not useful on their own)
///////////////////////////////////////

/// for use with enumConditional
char [] createEnumConditionalLoop(int Size) {
	char [] ret = "bool NeedsComma = false;\n";
	for (int lp = 1; lp < Size; lp += 2) {
		char [] curVal = itoa(lp);
		char [] curValMinus1 = itoa(lp - 1);
		ret ~=  "if ( (T.length > " ~ curVal ~") && (T[" ~ curVal ~ "]) ) {";
		if (lp > 1) {
		ret ~=  "	if (NeedsComma) {"
			"		ret ~= \",\n\";"
			"	}";
		}
		ret ~=	"	ret ~= \"\t\" ~ T[" ~ curValMinus1 ~ "];"
			"	NeedsComma = true;"
			"}";
		}
	return ret;
}
