#import "ChartboostHelper.h"

@implementation ChartboostHelper

@synthesize chartboost = _chartboost;

- (id) initWithAppID:(NSString *) appID appSignature:(NSString *)appSignature
{
	if(self = [super init])
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

	return self;
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

	void Chartboost_showInterstitial()
	{
		[chartboostHelper.chartboost showInterstitial];
	}

}