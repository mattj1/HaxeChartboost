package chartboost;

import cpp.Lib;
import flash.events.Event;
import flash.events.EventDispatcher;

class Chartboost extends EventDispatcher
{
	private static var sharedInstance : Chartboost;

	public static function getInstance() : Chartboost
	{
		if(sharedInstance == null)
		{
			sharedInstance = new Chartboost();
		}

		return sharedInstance;
	}

	private function new()
	{
		super();
		
		#if ios
			//Chartboost_set_event_callback( onEvent );
		#end
	}

	public function init( appId : String, appSignature: String )
	{
		chartboost_init(appId, appSignature);
	}

	private function onEvent()
	{

		dispatchEvent(new Event(""));
	}


	/// Start the Chartboost session
	public function startSession()
	{

	}

	/// Cache an interstitial
	public function cacheInterstitial()
	{

	}

	/// Cache an interstitial taking a location argument
	public function cacheInterstitialWithLocation( location:Int )
	{

	}

	/// Show an interstitial
	public function showInterstitial()
	{
		chartboost_show_interstitial();
	}

	/// Show an interstitial taking location and/or a view argument
	public function showInterstitialWithLocation( location:Int )
	{

	}

	/*
	/// Implement this to check if an interstitial is stored in cache for the default location
	public function hasCachedInterstitial():Bool
	{

	}

	/// Implement this to check if an interstitial is stored in cache for a specific location
	public function hasCachedInterstitial(location:Int):Bool
	{

	}
	*/

	/// Cache the More Apps page
	public function cacheMoreApps()
	{

	}

	/// Show the More Apps page
	public function showMoreApps()
	{

	}

	/// Returns the device identifier for internal testing purposes
	public function deviceIdentifier():String
	{
		throw "TODO: Not implemented";
		return "";
	}
/*
	/// Implement this to check if the more apps page is stored in the cache
	public function hasCachedMoreApps():Bool
	{

	}
*/
	/// Dismiss any Chartboost view programatically
	public function dismissChartboostView()
	{

	}

	#if ios
	
	private static var chartboost_init = Lib.load ("chartboost", "chartboost_init", 2);
	private static var chartboost_show_interstitial = Lib.load("chartboost", "chartboost_show_interstitial", 0);
	
	#end
	
}

