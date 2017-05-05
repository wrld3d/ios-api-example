#import "BasicMap.h"
#import "SamplesMessage.h"
@import Wrld;

@implementation BasicMap

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect viewBounds = self.view.bounds;
    
    CGFloat top = 96;
    CGFloat border = 32;
    viewBounds.size.width -= 2*border;
    viewBounds.size.height -= top + border;
    viewBounds.origin.x += border;
    viewBounds.origin.y += top;
    
    WRLDMapView *mapView = [[WRLDMapView alloc] initWithFrame:viewBounds];
    
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:mapView];
    
    [SamplesMessage showWithMessage:@"Welcome to WRLD maps"];
}

@end
