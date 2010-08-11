/** 
 * 
 *  Handy Mixins
 *  
 *  Authors: 	Tim Burrell
 *  Copyright: 	Copyright (c) 2007
 *  License:	<a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>
 *
**/

////////////////////////////////////////////////////////////////////////////
// Module
///////////////////////////////////////

module  libraryA.mixins.HandyMixins;

////////////////////////////////////////////////////////////////////////////
// Imports
///////////////////////////////////////

import	libraryA.mixins.HandyMixinHelpers;

////////////////////////////////////////////////////////////////////////////
// Mixins
///////////////////////////////////////

/**
 * Auto build class member
 *
 * Params:	Type =		Type of the property
 *		Name =		Name of the property
 * Returns:			String containing the resulting property
**/
template prop(Type, char [] Name) {
	const char [] prop = "private " ~ Type.stringof ~ " " ~ Name ~ ";" ;
}

/**
 * Auto build setter
 *
 * Params:	Type =		Type of the property
 *		Name =		Name of the property
 * Returns:			String containing the resulting property
**/
template propWrite(Type, char [] Name) {
	const char [] propWrite = "void set" ~ Name ~ "(inout " ~ Type.stringof ~ " The" ~ Name ~ ") { " 
		~ Name ~ " = The" ~ Name ~ "; }; \n\n"
		~ prop!(Type, Name);
}

/**
 * Auto build getter 
 *
 * Params:	Type =		Type of the property
 *		Name =		Name of the property
 * Returns:			String containing the resulting property
 *
 * Bugs: Not Implemented!
**/
template propRead(Type, char [] Name) {
	const char [] propRead = "void set" ~ Name ~ "(inout " ~ Type.stringof ~ " The" ~ Name ~ ") { " 
		~ Name ~ " = The" ~ Name ~ "; }; \n\n"
		~ prop!(Type, Name);
}

/**
 * Conditionally construct an enum
 *
 * Params:	Name =		Name of the enum
 *		T =		Enum elements and their conditions
 * Returns:			String containing the resulting enum
 *
 * Example:
 * -------------------------------------------------------------------------
 * const char [] RENDERER_CURSES = "False";
 * const char [] RENDERER_VT102 = "True";
 * const char [] RENDERER_X11 = "True";
 *
 * mixin(enumConditional!("RendererClass", 
 *	"RendererCurses", RENDERER_CURSES == "True",
 *	"RendererVT102",  RENDERER_VT102 == "True",
 *	"RendererX11",    RENDERER_X11 == "True"
 * ).createEnum());
 * -------------------------------------------------------------------------
 * Would result in the following enum:
 * -------------------------------------------------------------------------
 * enum {
 *	RendererVT102,
 *	RendererX11
 * }
 * -------------------------------------------------------------------------
 * Obviously, this is all done at compile time.
**/

template enumConditional(char [] Name, T...) {
	//alias T tupleof;
	char [] createEnum() {
		char [] ret = "enum " ~ Name ~ " {\n";	
		mixin(createEnumConditionalLoop(T.length));
		return ret ~ "\n}";
	}
}

