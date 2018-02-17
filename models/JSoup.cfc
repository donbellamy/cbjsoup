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
		// TODO: allow options here
		/* 
		none()
		simpleText()
		basic()
		basicWithImages()
		relaxed()
		*/
		return variables.jsoup.clean( arguments.html, variables.whitelist );
	}

	function onDIComplete() {
		loadJsoup();
	}

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