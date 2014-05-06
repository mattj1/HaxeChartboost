HaxeChartboost
==============

Haxelib for Chartboost

### How to use (iOS)

```
import chartboost.Chartboost;
import chartboost.ChartboostEvent;

...
	
	// Initialize Chartboost with app id/signature
	Chartboost.getInstance().init("YOUR_APP_ID", "YOUR_APP_SIGNATURE");

	// Show an ad
	Chartboost.getInstance().showInterstitial();
	
```

### Capturing events

```
	function adWasClosed()
	{
		trace("User closed the ad.")
		Chartboost.getInstance().removeEventListener(Chartboost.DID_DISMISS_INTERSTITIAL, adWasClosed);
	}
	
	Chartboost.getInstance().addEventListener(Chartboost.DID_DISMISS_INTERSTITIAL, adWasClosed);

```

### Current status:

#### iOS

WIP.
- Can init with id/signature.
- Can show an interstitial ad

#### Android

Not supported yet.

### Roadmap

IOS:
- Init
- start session
- Show interstitial
- didDismissInterstitial event

Android:
- Clean up Build.xml to support Android
- Init
- start session
- Show interstitial
- callback when user closes interstitial
