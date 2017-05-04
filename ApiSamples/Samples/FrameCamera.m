#import "FrameCamera.h"
@import Wrld;


@implementation FrameCamera

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WRLDMapView *mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:mapView];
    
    WRLDCoordinateBounds bounds = WRLDCoordinateBoundsMake(CLLocationCoordinate2DMake(37.786647, -122.407015), CLLocationCoordinate2DMake(37.798886, -122.395116));
    
    [mapView setCoordinateBounds:bounds animated:YES];
}

@end
