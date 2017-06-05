#import "MarkerChangeLocation.h"
@import Wrld;


@interface MarkerChangeLocation ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MarkerChangeLocation
{
    NSTimer *myTimer;
    BOOL locationToggle;
    CLLocationCoordinate2D initialMarkerLocation;
    CLLocationCoordinate2D alteredMarkerLocation;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationToggle = false;
    initialMarkerLocation = CLLocationCoordinate2DMake(37.784560, -122.402092);
    alteredMarkerLocation = CLLocationCoordinate2DMake(37.783372, -122.400834);
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:initialMarkerLocation];
    marker.title = @"This is a moving marker";
    [_mapView addMarker:marker];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                               target:self
                                             selector:@selector(toggleLocation:)
                                             userInfo:marker
                                              repeats:YES];
}
    
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [myTimer invalidate];
    myTimer = nil;
}

- (void)toggleLocation:(NSTimer *)timer
{
    WRLDMarker* marker = timer.userInfo;
    marker.coordinate = locationToggle ? initialMarkerLocation : alteredMarkerLocation;
    locationToggle = !locationToggle;
}

@end
