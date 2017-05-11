#import "MarkerTappedNotification.h"
#import "SamplesMessage.h"
@import Wrld;


@interface MarkerTappedNotification () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MarkerTappedNotification

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDMarker* markerA = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(37.784560, -122.402092)];
    markerA.title = @"Marker A";
    WRLDMarker* markerB = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(37.783372, -122.400834)];
    markerB.title = @"Marker B";
    
    [_mapView addMarkers:@[markerA, markerB]];
}

#pragma mark - WRLDMapViewDelegate implementation

- (void)mapView:(WRLDMapView *)mapView didTapMarker:(WRLDMarker *)marker
{
    NSString *message = [NSString stringWithFormat:@"'%@' [%f, %f]", marker.title, marker.coordinate.latitude, marker.coordinate.longitude];
    [SamplesMessage showWithMessage:message
                        andDuration:[NSNumber numberWithInt:2]];
}

@end
