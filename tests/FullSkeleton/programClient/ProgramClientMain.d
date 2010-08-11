/** 
 * 
 *  FullSkeleton -- A skeleton for your CMakeD app
 *  
 *  Authors: 	Tim Burrell
 *  Copyright: 	Copyright (c) 2007
 *  License:	<a href="http://www.apache.org/licenses/LICENSE-2.0">Apache License, Version 2.0</a>
 *
**/

////////////////////////////////////////////////////////////////////////////
// Module
///////////////////////////////////////

module  programClient.ProgramClientMain;

////////////////////////////////////////////////////////////////////////////
// Imports
///////////////////////////////////////

import	config;

import  programClient.ProgramClientApp;

import	libraryA.io.Output;

////////////////////////////////////////////////////////////////////////////
// Main
///////////////////////////////////////

/**
 * Main function
**/
void main(char [][] Args) {
	// create the App
	scope ProgramClientApp App;
	try {
		App = new ProgramClientApp(Args);
	} catch (Exception e) {
		Out("Unable to Initialize " ~ PACKAGE ~ ":\n    " ~ e.msg ~ "\n");
		return -1;
	}

	// run the app
	try {
		App.enterLoop();
	} catch (Exception e) {
		Out("Unable to Run " ~ PACKAGE ~ ": " ~ e.msg ~ "\n");
		return -1;
	}
}

