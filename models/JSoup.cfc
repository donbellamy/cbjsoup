component singleton threadsafe {

	property name="javaLoader" inject="loader@cbjavaloader";
	property name="settings" inject="coldbox:setting:jsoup";

	function init() {
		return this;
	}

	function parse( required string html ) {
		return variables.jsoup.parse( arguments.html );
	}

	function connect( required string url ) {
		return variables.jsoup.connect( arguments.url ).get();
	}

	function clean( required string html ) {
		return variables.jsoup.clean( arguments.html );
	}

	function onDIComplete() {
		loadJsoup();
	}

	private void function loadJsoup() {
		if ( !isJsoupLoaded() ) {
			variables.jsoup = javaLoader.create("org.jsoup.Jsoup");
		}
	}
	
	private boolean function isJsoupLoaded() {
		return structKeyExists( variables, "jsoup" );
	}

}