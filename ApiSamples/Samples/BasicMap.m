#import "BasicMap.h"
#import "SamplesMessage.h"
@import Wrld;

@implementation BasicMap

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WRLDMapView *mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:mapView];
    
    [SamplesMessage showWithMessage:@"Welcome to WRLD maps"];
}

@end
