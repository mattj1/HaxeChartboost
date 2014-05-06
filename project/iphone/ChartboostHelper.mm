#import "ChartboostHelper.h"

@implementation ChartboostHelper

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

extern "C" void chartboost_send_event(const char* type, const char* data);

@synthesize chartboost = _chartboost;

- (id) initWithAppID:(NSString *) appID appSignature:(NSString *)appSignature
{
	if(self = [super init])
	{
		// Latest version of Chartboost does not support iOS 5.x and earlier.

		if([self canShowAds])
		{
			_chartboost = [Chartboost sharedChartboost];
	        
	        _chartboost.appId = appID;
	        _chartboost.appSignature = appSignature;
	        
	        //Required for use of delegate methods.
	        _chartboost.delegate = self;
	        
	        // Begin a user session. Must not be dependent on user actions or any prior network requests.
	        // Must be called every time your app becomes active.
	        [_chartboost startSession];
    	}
	}

	return self;
}

#pragma mark - Helper methods

- (bool) canShowAds
{
    return SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.0");
}

- (void) showInterstitial
{
	if([self canShowAds])
	{
		[[Chartboost sharedChartboost] showInterstitial];
	} else {
		chartboost_send_event("didDismissInterstitial", "ERROR: Ads not supported.");
	}
}

#pragma mark - ChartboostDelegate methods
- (BOOL)shouldDisplayInterstitial:(CBLocation)location {
    // NSLog(@"about to display interstitial at location %d", location);

    // For example:
    // if the user has left the main menu and is currently playing your game, return NO;
    
    // Otherwise return YES to display the interstitial
    return YES;
}


/*
 * didFailToLoadInterstitial
 *
 * This is called when an interstitial has failed to load. The error enum specifies
 * the reason of the failure
 */

- (void)didFailToLoadInterstitial:(CBLocation)location withError:(CBLoadError)error {
    switch(error){
        case CBLoadErrorInternetUnavailable: {
            NSLog(@"Failed to load Interstitial, no Internet connection !");
        } break;
        case CBLoadErrorInternal: {
            NSLog(@"Failed to load Interstitial, internal error !");
        } break;
        case CBLoadErrorNetworkFailure: {
            NSLog(@"Failed to load Interstitial, network error !");
        } break;
        case CBLoadErrorWrongOrientation: {
            NSLog(@"Failed to load Interstitial, wrong orientation !");
        } break;
        case CBLoadErrorTooManyConnections: {
            NSLog(@"Failed to load Interstitial, too many connections !");
        } break;
        case CBLoadErrorFirstSessionInterstitialsDisabled: {
            NSLog(@"Failed to load Interstitial, first session !");
        } break;
        case CBLoadErrorNoAdFound : {
            NSLog(@"Failed to load Interstitial, no ad found !");
        } break;
        case CBLoadErrorSessionNotStarted : {
            NSLog(@"Failed to load Interstitial, session not started !");
        } break;
        default: {
            NSLog(@"Failed to load Interstitial, unknown error !");
        }
    }
}

/*
 * didCacheInterstitial
 *
 * Passes in the location name that has successfully been cached.
 *
 * Is fired on:
 * - All assets loaded
 * - Triggered by cacheInterstitial
 *
 * Notes:
 * - Similar to this is: (BOOL)hasCachedInterstitial:(NSString *)location;
 * Which will return true if a cached interstitial exists for that location
 */

- (void)didCacheInterstitial:(CBLocation)location {
    NSLog(@"interstitial cached at location %d", location);
}

/*
 * didFailToLoadMoreApps
 *
 * This is called when the more apps page has failed to load for any reason
 *
 * Is fired on:
 * - No network connection
 * - No more apps page has been created (add a more apps page in the dashboard)
 * - No publishing campaign matches for that user (add more campaigns to your more apps page)
 *  -Find this inside the App > Edit page in the Chartboost dashboard
 */

- (void)didFailToLoadMoreApps:(CBLoadError)error {
    switch(error){
        case CBLoadErrorInternetUnavailable: {
            NSLog(@"Failed to load More Apps, no Internet connection !");
        } break;
        case CBLoadErrorInternal: {
            NSLog(@"Failed to load More Apps, internal error !");
        } break;
        case CBLoadErrorNetworkFailure: {
            NSLog(@"Failed to load More Apps, network error !");
        } break;
        case CBLoadErrorWrongOrientation: {
            NSLog(@"Failed to load More Apps, wrong orientation !");
        } break;
        case CBLoadErrorTooManyConnections: {
            NSLog(@"Failed to load More Apps, too many connections !");
        } break;
        case CBLoadErrorFirstSessionInterstitialsDisabled: {
            NSLog(@"Failed to load More Apps, first session !");
        } break;
        case CBLoadErrorNoAdFound: {
            NSLog(@"Failed to load More Apps, Apps not found !");
        } break;
        case CBLoadErrorSessionNotStarted : {
            NSLog(@"Failed to load Interstitial, session not started !");
        } break;
        default: {
            NSLog(@"Failed to load More Apps, unknown error !");
        }
    }
}

/*
 * didDismissInterstitial
 *
 * This is called when an interstitial is dismissed
 *
 * Is fired on:
 * - Interstitial click
 * - Interstitial close
 *
 * #Pro Tip: Use the delegate method below to immediately re-cache interstitials
 */

// - (void)didDismissInterstitial:(NSString *)location {
- (void)didDismissInterstitial:(CBLocation)location {

    chartboost_send_event("didDismissInterstitial", "test data");

    NSLog(@"dismissed interstitial at location %d", location);
    [[Chartboost sharedChartboost] cacheInterstitial:location];
}

/*
 * didDismissMoreApps
 *
 * This is called when the more apps page is dismissed
 *
 * Is fired on:
 * - More Apps click
 * - More Apps close
 *
 * #Pro Tip: Use the delegate method below to immediately re-cache the more apps page
 */

- (void)didDismissMoreApps {
    NSLog(@"dismissed more apps page, re-caching now");
    [[Chartboost sharedChartboost] cacheMoreApps];
}

/*
 * shouldRequestInterstitialsInFirstSession
 *
 * This sets logic to prevent interstitials from being displayed until the second startSession call
 *
 * The default is YES, meaning that it will always request & display interstitials.
 * If your app displays interstitials before the first time the user plays the game, implement this method to return NO.
 */

- (BOOL)shouldRequestInterstitialsInFirstSession {
    return YES;
}

@end

extern "C"
{
	static ChartboostHelper *chartboostHelper = nil;

	void Chartboost_Init(const char *appID, const char *appSignature)
	{
		chartboostHelper = [[ChartboostHelper alloc] 
			initWithAppID:[[NSString alloc] initWithUTF8String:appID]
			appSignature:[[NSString alloc] initWithUTF8String:appSignature]
			];
	}

	void Chartboost_startSession()
	{
		if(chartboostHelper != nil)
		{
			[chartboostHelper.chartboost startSession];
		}
	}

	void Chartboost_showInterstitial()
	{
		if(chartboostHelper != nil)
		{
			[chartboostHelper showInterstitial];
		}
	}

}