#import "MarkerCustomIcon.h"
@import Wrld;


@interface MarkerCustomIcon ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MarkerCustomIcon

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.78456, -122.402092)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(37.78456, -122.402092)];
    marker.title = @"This is a marker with a custom park icon";
    marker.iconKey = @"park";
    [_mapView addMarker:marker];
}

@end
