#import "MapTappedNotification.h"
#import "SamplesMessage.h"
@import Wrld;


@interface MapTappedNotification () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MapTappedNotification
{
    WRLDMarker* marker;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
}

#pragma mark - WRLDMapViewDelegate implementation

- (void)mapView:(WRLDMapView *)mapView didTapMap:(WRLDCoordinateWithAltitude)coordinateWithAltitude
{
    NSString *message = [NSString stringWithFormat:@"LatLng [%f, %f]; altitude %f m", coordinateWithAltitude.coordinate.latitude, coordinateWithAltitude.coordinate.longitude, coordinateWithAltitude.altitude];
    [SamplesMessage showWithMessage:message
                        andDuration:[NSNumber numberWithInt:3]];
    
    if (marker != nil)
    {
        [_mapView removeMarker:marker];
        marker = nil;
    }
    
    if ([mapView isIndoors])
    {
        marker = [WRLDMarker markerAtCoordinate:coordinateWithAltitude.coordinate
                                    inIndoorMap:[[mapView activeIndoorMap] indoorId]
                                        onFloor:[mapView currentFloorIndex]];
    }
    else
    {
        marker = [WRLDMarker markerAtCoordinate:coordinateWithAltitude.coordinate];
    }
    
    [_mapView addMarker:marker];
}



@end
