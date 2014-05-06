HaxeChartboost
==============

Haxelib for Chartboost

#### How to use

*Note, these instructions are for iOS only. They will be updated for accuracy when Android support is added.*

```
import chartboost.Chartboost;

...
	
	// Initialize Chartboost with app id/signature
	Chartboost.getInstance().init("YOUR_APP_ID", "YOUR_APP_SIGNATURE");

	// Show an ad
	Chartboost.getInstance().showInterstitial();

	// Call startSession whenever the app comes back into focus
	//  (HaxePunk Example)

	override public function focusGained()
	{
		Chartboost.getInstance().startSession();
	}

	
```

#### Capturing events

```
import chartboost.ChartboostEvent;

...

	function adWasClosed()
	{
		trace("User closed the ad.")
		Chartboost.getInstance().removeEventListener(Chartboost.DID_DISMISS_INTERSTITIAL, adWasClosed);
	}
	
	Chartboost.getInstance().addEventListener(Chartboost.DID_DISMISS_INTERSTITIAL, adWasClosed);

```

#### Current status:

##### iOS

WIP.
- Can init with id/signature.
- Can show an interstitial ad
- Dispatches event when interstitial is cloed

#### Android

Not supported yet.

#### Roadmap

IOS:
- [DONE] Init
- [DONE] Start session
- [DONE] Show interstitial
- [DONE] didDismissInterstitial event

Android:
- Clean up Build.xml to support Android
- Init
- start session
- Show interstitial
- callback when user closes interstitial
