#import "Search.h"
#import "SamplesMessage.h"
@import Wrld;

@implementation Search

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WRLDMapView *mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // set the center of the map and the zoom level
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                       zoomLevel:15
                        animated:NO];
    
    [self.view addSubview:mapView];
    
    [SamplesMessage showWithMessage:@"Search Widget"];
}

@end

