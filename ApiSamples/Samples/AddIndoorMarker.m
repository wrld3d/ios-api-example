#import "AddIndoorMarker.h"
@import Wrld;


@interface AddIndoorMarker ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation AddIndoorMarker

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.4599662, -2.9781313)
                        zoomLevel:17
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(56.4599662, -2.9781313) inIndoorMap:@"westport_house" onFloor:0];
    marker.title = @"Marker on ground floor";
    [_mapView addMarker:marker];
    
}

@end
