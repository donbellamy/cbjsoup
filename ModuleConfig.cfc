/**
 * CB JSoup
 * Module Config
 * @author Don Bellamy <don@perfectcode.com>
 */
component {

	// Module properties
	this.title = "CB JSoup";
	this.author = "Don Bellamy <don@perfectcode.com>";
	this.webURL = "https://github.com/donbellamy/cbjsoup";
	this.description = "Leverages the JSoup html parser for extracting and manipulating html";
	this.version = "1.1.0";
	this.viewParentLookup = true;
	this.layoutParentLookup = true;
	this.entryPoint	= "cbjsoup";
	this.cfMapping = "cbjsoup";
	this.dependencies = ["cbjavaloader"];

	/**
	 * Configure module properties
	 */
	function configure()  {}

	/**
	 * Fired when module is loaded
	 */
	function onLoad() {

		var settings = controller.getConfigSettings();
		parseParentSettings();
		wireBox.getInstance("loader@cbjavaloader").appendPaths( settings.jsoup.libPath );

	}

	/**
	 * Parse the parent settings
	 */
	private function parseParentSettings() {

		var config = controller.getSetting("ColdBoxConfig");
		var settings = controller.getConfigSettings();
		var jsoupDSL = config.getPropertyMixin( "jsoup", "variables", structNew() );

		var defaults = {
			libPath = modulePath & "/models/lib"
		};

		if ( !structKeyExists( settings, "jsoup" ) ) {
			settings.jsoup = {};
		}

		structAppend( settings.jsoup, defaults );
		structAppend( settings.jsoup, jsoupDSL, true );

	}

}