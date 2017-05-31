#import "MarkerWithAbsoluteAltitude.h"
@import Wrld;


@interface MarkerWithAbsoluteAltitude ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MarkerWithAbsoluteAltitude

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.802617, -122.405783)
                        zoomLevel:18
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(37.802617, -122.405783)];
    marker.title = @"Telegraph Hill";
    marker.elevationMode = WRLDElevationModeHeightAboveSeaLevel;
    marker.elevation = 80.7f;
    [_mapView addMarker:marker];
}

@end
