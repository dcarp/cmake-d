/** 
 * 
 *  ProgramClientApp Class -- Common app init code encapsulation
 *  
 *  Authors: 	Tim Burrell
 *  Copyright: 	Copyright (c) 2007
 *  License:	<a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>
 *
**/

////////////////////////////////////////////////////////////////////////////
// Module
///////////////////////////////////////

module  programClient.ProgramClientApp;

////////////////////////////////////////////////////////////////////////////
// Imports
///////////////////////////////////////

import  config;

import  programClient.ProgramClient;

import	libraryB.LibraryB;

import	libraryA.io.Output;
	
////////////////////////////////////////////////////////////////////////////
// Definitions
///////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
// Class Definition
///////////////////////////////////////

/**
 * This is the ProgramClientApp class.  It is responsible for handling init stuff
 * like command line parsing and so forth.
**/
class ProgramClientApp : ProgramClient {
	////////////////////////////////////////////////////////////////////
	// Construction
	///////////////////////////////
	
	/**
	 * Default Constructor
	**/
	this(char [][] Args) {
		Out(props());
		initialize(Args);
	}

	/**
	 * Destructor
	**/
	~this() {
		Out("Shutting Down...");
	}
	
	////////////////////////////////////////////////////////////////////
	// Public functions
	///////////////////////////////
	
	/**
	 * Get help info
	**/
	char [] getHelp() {
		char [] output = "You must specify a renderer.  Available renderers: ";
		version (RendererX11)
			output ~= "x11 ";
		version (RendererWin)
			output ~= "windows ";
		return output;
	}
				
	/**
	 * Get the program's propers
	 *
	 * Returns:	Formatted propers
	**/
	char [] props() {
		return "\n" ~ PACKAGE ~ " v" ~ VERSION ~ " -=- (c) 2007\n";
	}
	
	////////////////////////////////////////////////////////////////////
	
private:
	
	////////////////////////////////////////////////////////////////////
	// Private Functions
	///////////////////////////////	
		
	/**
	 * Initialize the program
	 *
	 * Params:	Args =		Command line arguments
	 * Throws:	Exception	If initialization error occurs
	**/
	void initialize(char [][] Args) {
		if (Args.length < 2) 
			throw new Exception(getHelp());
		bool RendererFound = false;
		version (RendererX11) {
			if (Args[1] == "x11") {
				mRendererClass = RendererClass.RendererX11;
				RendererFound = true;
			}
		}
		version (RendererWin) {
			if (Args[1] == "windows") {
				mRendererClass = RendererClass.RendererWin;
				RendererFound = true;
			}
		}
		if (RendererFound)
			ProgramClient.initialize(mRendererClass);
		else
			throw new Exception(getHelp());
	}
		
	////////////////////////////////////////////////////////////////////
	// Private Members
	///////////////////////////////

	RendererClass 		mRendererClass;				/// Renderer class
}

