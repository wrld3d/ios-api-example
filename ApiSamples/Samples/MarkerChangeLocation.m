#import "MarkerChangeLocation.h"
@import Wrld;


@interface MarkerChangeLocation ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MarkerChangeLocation
{
    BOOL locationToggle;
    CLLocationCoordinate2D initialMarkerLocation;
    CLLocationCoordinate2D alteredMarkerLocation;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationToggle = false;
    initialMarkerLocation = CLLocationCoordinate2DMake(37.7858, -122.401);
    alteredMarkerLocation = CLLocationCoordinate2DMake(37.7838, -122.403);
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)];
    marker.title = @"This is a moving marker";
    [_mapView addMarker:marker];
    
    [NSTimer scheduledTimerWithTimeInterval:2
                                     target:self
                                   selector:@selector(onDelay:)
                                   userInfo:marker
                                    repeats:YES];
}

- (void)onDelay:(NSTimer *)timer
{
    WRLDMarker* marker = timer.userInfo;
    marker.coordinate = locationToggle ? initialMarkerLocation : alteredMarkerLocation;
    locationToggle = !locationToggle;
}

@end
