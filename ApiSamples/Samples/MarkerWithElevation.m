#import "MarkerWithElevation.h"
@import Wrld;


@interface MarkerWithElevation ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MarkerWithElevation

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7952, -122.4028)
                        zoomLevel:16
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(37.7952, -122.4028)];
    marker.title = @"Transamerica Pyramid";
    marker.elevation = 260.0f;
    [_mapView addMarker:marker];
}

@end
