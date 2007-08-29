/** 
 * 
 *  Exception Class
 *  
 *  Authors: 	Tim Burrell
 *  Copyright: 	Copyright (c) 2007
 *  License:	<a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>
 *
**/

////////////////////////////////////////////////////////////////////////////
// Module
///////////////////////////////////////

module  libraryA.core.Exception;

////////////////////////////////////////////////////////////////////////////
// Imports
///////////////////////////////////////

version (Tango)
	import	tango.core.Exception;

////////////////////////////////////////////////////////////////////////////
// Typedef's / Enums
///////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
// Exception Classes
///////////////////////////////////////

/**
 * PathNotFoundException Class
**/
version (Tango) {
	class PathNotFoundException : IOException {
		/// Default Constructor
		this (char [] Message) {
			super(Message);
		}
	}
} else {
	class PathNotFoundException : Exception {
		/// Default Constructor
		this (char [] Message) {
			super(Message);
		}
	}
}

