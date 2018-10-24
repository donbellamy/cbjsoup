/**
 * CB JSoup
 * JSoup Model
 * @author Don Bellamy <don@perfectcode.com>
 */
component singleton threadsafe {

	// Dependencies
	property name="javaLoader" inject="loader@cbjavaloader";
	property name="settings" inject="coldbox:setting:jsoup";

	/**
	 * Constructor
	 * @return JSoup
	 */
	JSoup function init() {
		return this;
	}

	/**
	 * Gets the jsoup instance
	 */
	function getJsoup() {
		return variables.jsoup;
	}

	/**
	 * Gets the whitelist instance
	 * @mode The whitelist mode to use
	 */
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

	/**
	 * Parses an html string
	 * @html The html string to parse
	 */
	function parse( required string html ) {
		return variables.jsoup.parse( arguments.html );
	}

	/**
	 * Parses a body fragment
	 * @html The html string to parse
	 */
	function parseBodyFragment( required string html ) {
		return variables.jsoup.parseBodyFragment( arguments.html );
	}

	/**
	 * Gets a url to parse
	 * @url The url to connect
	 */
	function connect( required string url ) {
		return variables.jsoup.connect( arguments.url ).get();
	}

	/**
	 * Cleans an html string
	 * @html The html string to clean
	 * @whitelist The whitelist to use
	 */
	function clean( required string html, any whitelist=getWhiteList() ) {
		return variables.jsoup.clean( arguments.html, arguments.whitelist );
	}

	/**
	 * Fired on DI complete, loads Jsoup
	 */
	function onDIComplete() {
		loadJsoup();
	}

	/************************************** Private *********************************************/

	/**
	 * Loads Jsoup
	 */
	private void function loadJsoup() {
		if ( !isJsoupLoaded() ) {
			variables.jsoup = javaLoader.create("org.jsoup.Jsoup");
			variables.whitelist = javaLoader.create("org.jsoup.safety.Whitelist");
		}
	}

	/**
	 * Checks to see if Jsoup is loaded
	 * @return True if jsoup is loaded, false if not
	 */
	private boolean function isJsoupLoaded() {
		return structKeyExists( variables, "jsoup" );
	}

}