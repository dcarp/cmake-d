/** 
 * 
 *  Main LibraryB Class
 *  
 *  Authors: 	Tim Burrell
 *  Copyright: 	Copyright (c) 2007
 *  License:	<a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>
 *
**/
 
////////////////////////////////////////////////////////////////////////////
// Module
///////////////////////////////////////

module  libraryB.LibraryB;

////////////////////////////////////////////////////////////////////////////
// Imports
///////////////////////////////////////

import	config;

import	libraryB.render.Renderer;
version(RendererX11) {
import	libraryB.render.RendererX11; 
}
version(RendererWin) {
import	libraryB.render.RendererWin;
}

import	libraryA.io.Output;
import	libraryA.mixins.HandyMixins;

////////////////////////////////////////////////////////////////////////////
// Typedef's / enums
///////////////////////////////////////

/**
 * RendererClass Enum
 *
 * Conditional Enum that can have different elements based on what 
 * Renderers have been selected for compilation
**/ 
mixin(enumConditional!("RendererClass", 
	"RendererX11",    RENDERER_X11 == "True",
	"RendererWin",    RENDERER_WIN == "True"
).createEnum());

////////////////////////////////////////////////////////////////////////////
// Class Definition
///////////////////////////////////////

/**
 * This is the main instance of LibraryB
 *
 * Your program should inherit this class
**/
class LibraryB {	
	////////////////////////////////////////////////////////////////////
	// Construction
	///////////////////////////////
	
	/**
	 * Default Constructor
	**/
	this() {
		Out("Construct Library B");
	}

	/**
	 * Destructor
	**/
	~this() {
		Out("Destruct Library B");
	}
	
	////////////////////////////////////////////////////////////////////
	// Public functions
	///////////////////////////////
		
	/**
	 * Enter the processing loop
	**/
	void enterLoop() {
		if (mRenderer is null)
			throw new Exception("You must intialize LibraryB!");
			
		// do event loop here!
	}
	
	/**
	 * Initialize LibraryB with a specific renderer
	 *
	 * Params:	Renderer =	Renderer to use
	**/
	void initialize(RendererClass Renderer) {
		// allocate the renderer
		switch (Renderer) {
		version(RendererX11) {
			case RendererClass.RendererX11:
				mRenderer = new RendererX11();
				break;
		}
		version(RendererWin) {
			case RendererClass.RendererWin:
				mRenderer = new RendererWindows();
				break;
		}
		default:
			throw new Exception("Invalid Renderer Specified!");
		}
		
		// initialize the renderer
		mRenderer.initialize();
	}
		
	////////////////////////////////////////////////////////////////////
	
private:
	
	////////////////////////////////////////////////////////////////////
	// Private Functions
	///////////////////////////////	
			
	////////////////////////////////////////////////////////////////////
	// Private Members
	///////////////////////////////

	Renderer		mRenderer;				/// The renderer
}

