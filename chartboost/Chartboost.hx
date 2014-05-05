package chartboost;

import flash.events.Event;
import flash.events.EventDispatcher;

class Chartboost extends EventDispatcher
{
	public function new( appId : String, appSignature: String )
	{
		super();
		
		#if ios
			Chartboost_set_event_callback( onEvent );
		#endif
	}

	private function onEvent()
	{

		dispatchEvent(new Event());
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
	public function cacheInterstitial( location:Int )
	{

	}

	/// Show an interstitial
	public function showInterstitial()
	{

	}

	/// Show an interstitial taking location and/or a view argument
	public function showInterstitial( location:Int )
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
	
}

