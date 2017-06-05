#import "AddIndoorMarker.h"
@import Wrld;
@import WrldWidgets;


@interface AddIndoorMarker ()

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;

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
    
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds];
    [_indoorControlView setMapView:_mapView];
    
    [self.view addSubview:_mapView];
    [self.view addSubview:_indoorControlView];
    
    const int numberOfFloors = 7;
    
    for (int floorId = 0; floorId < numberOfFloors; ++floorId)
    {
        WRLDMarker* marker = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(56.459948, -2.978094) inIndoorMap:@"westport_house" onFloor:floorId];
        marker.title = [NSString stringWithFormat:@"Marker on floor %d", floorId];
        [_mapView addMarker:marker];
    }
}

@end
