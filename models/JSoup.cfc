component singleton threadsafe {

	property name="javaLoader" inject="loader@cbjavaloader";
	property name="settings" inject="coldbox:setting:jsoup";

	function init() {
		return this;
	}

	function getJsoup() {
		return variables.jsoup;
	}

	function getWhitelist( string mode="relaxed" ) {
		var whitelist = variables.whitelist;
		switch ( arguments.mode ) {
			case "none":
				whitelist = whitelist.none();
				break;
			case "simpleText":
				whitelist = whitelist.simpleText();
				break;
			case "basic":
				whitelist = whitelist.basic();
				break;
			case "basicWithImages":
				whitelist = whitelist.basicWithImages();
				break;
			default:
				whitelist = whitelist.relaxed();
		}
		return whitelist;
	}

	function parse( required string html ) {
		return variables.jsoup.parse( arguments.html );
	}

	function parseBodyFragment( required string html ) {
		return variables.jsoup.parseBodyFragment( arguments.html );
	}

	function connect( required string url ) {
		return variables.jsoup.connect( arguments.url ).get();
	}

	function clean( required string html, any whitelist=getWhiteList() ) {
		return variables.jsoup.clean( arguments.html, arguments.whitelist );
	}

	function onDIComplete() {
		loadJsoup();
	}

	/************************************** private *********************************************/

	private void function loadJsoup() {
		if ( !isJsoupLoaded() ) {
			variables.jsoup = javaLoader.create("org.jsoup.Jsoup");
			variables.whitelist = javaLoader.create("org.jsoup.safety.Whitelist");
		}
	}

	private boolean function isJsoupLoaded() {
		return structKeyExists( variables, "jsoup" );
	}

}