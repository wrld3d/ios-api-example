#import "PlaceObjectsOnBuildings.h"
@import Wrld;

@interface PlaceObjectsOnBuildings() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation PlaceObjectsOnBuildings
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;

    // set the center of the map and the zoom level
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.795641, -122.404173)
                        zoomLevel:17
                         animated:NO];

    [self.view addSubview:_mapView];
}

- (void)addMarkerAboveBuildingAtCoordinate:(CLLocationCoordinate2D)coordinate
                                     title:(NSString*)title
{
    WRLDPickResult* pickResult = [_mapView pickFeatureAtLocation:coordinate];
    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:coordinate];
    marker.title = title;
    marker.elevation = pickResult.intersectionPoint.altitude;
    marker.elevationMode = WRLDElevationModeHeightAboveSeaLevel;
    [_mapView addMarker:marker];
}

#pragma mark - WRLDMapViewDelegate implementation

- (void)mapViewDidFinishLoadingInitialMap:(WRLDMapView *)mapView
{
    [self addMarkerAboveBuildingAtCoordinate:CLLocationCoordinate2DMake(37.795159, -122.404336) title:@"Point A"];
    [self addMarkerAboveBuildingAtCoordinate:CLLocationCoordinate2DMake(37.794817, -122.403543) title:@"Point B"];
}

@end


