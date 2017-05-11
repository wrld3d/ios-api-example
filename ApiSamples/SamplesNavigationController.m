#import "SamplesNavigationController.h"

@interface SamplesNavigationController ()

@end

@implementation SamplesNavigationController

- (BOOL) shouldAutorotate
{
    return [[self visibleViewController] shouldAutorotate];
}

@end
