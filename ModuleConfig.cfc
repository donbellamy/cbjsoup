component {

	this.title = "JSoup";
	this.author = "Perfect Code, LLC";
	this.webURL = "https://perfectcode.com";
	this.description = "Leverages the JSoup html parser for extracting and manipulating html";
	this.version = "1.0.0";
	this.viewParentLookup = true;
	this.layoutParentLookup = true;
	this.entryPoint	= "cbjsoup";
	this.cfMapping = "cbjsoup";
	this.dependencies = ["cbjavaloader"];

	function configure()  {}

	function onLoad() {

		var settings = controller.getConfigSettings();
		parseParentSettings();
		wireBox.getInstance("loader@cbjavaloader").appendPaths( settings.jsoup.libPath );

	}

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