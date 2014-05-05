#import <Foundation/Foundation.h>
#import "Chartboost.h"

@interface ChartboostHelper : NSObject<ChartboostDelegate>

@property(readonly) Chartboost *chartboost;
@end
