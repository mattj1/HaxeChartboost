package chartboost;

import cpp.Lib;
import flash.events.Event;
import flash.events.EventDispatcher;

class Chartboost extends EventDispatcher
{
	private static var sharedInstance : Chartboost;

	public static inline var DID_DISMISS_INTERSTITIAL:String = "DID_DISMISS_INTERSTITIAL";

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
			chartboost_set_event_callback( onEvent );
		#end
	}

	public function init( appId : String, appSignature: String )
	{
		#if ios
			chartboost_init(appId, appSignature);
		#end
	}

	private function onEvent(inEvent:Dynamic)
	{
		var type = Std.string (Reflect.field (inEvent, "type"));
		var data = Std.string (Reflect.field (inEvent, "data"));
		
		trace("Chartboost onEvent: " + type + " " + data);
		switch(type)
		{
			case "didDismissInterstitial":
				dispatchEvent(new ChartboostEvent(DID_DISMISS_INTERSTITIAL));
		}
		
	}

	// Chartboost API ===============================================

	/// Start the Chartboost session
	public function startSession()
	{
		#if ios
			chartboost_start_session();
		#end
	}

	/// Cache an interstitial
	public function cacheInterstitial()
	{
		throw "TODO: Not implemented";
	}

	/// Cache an interstitial taking a location argument
	public function cacheInterstitialWithLocation( location:Int )
	{
		throw "TODO: Not implemented";
	}

	/// Show an interstitial
	public function showInterstitial()
	{
		#if ios
			chartboost_show_interstitial();
		#end
	}

	/// Show an interstitial taking location and/or a view argument
	public function showInterstitialWithLocation( location:Int )
	{
		throw "TODO: Not implemented";
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
		throw "TODO: Not implemented";
	}

	/// Show the More Apps page
	public function showMoreApps()
	{
		throw "TODO: Not implemented";
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
		throw "TODO: Not implemented";
	}

	#if ios
	
	private static var chartboost_init = Lib.load ("chartboost", "chartboost_init", 2);
	private static var chartboost_start_session = Lib.load("chartboost", "chartboost_start_session", 0);
	private static var chartboost_show_interstitial = Lib.load("chartboost", "chartboost_show_interstitial", 0);
	
	private static var chartboost_set_event_callback = Lib.load("chartboost", "chartboost_set_event_callback", 1);
	#end
	
}

