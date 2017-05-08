#import "MapSceneLoadedNotification.h"
#import "SamplesMessage.h"
@import Wrld;


@interface MapSceneLoadedNotification () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MapSceneLoadedNotification

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
}

#pragma mark - WRLDMapViewDelegate implementation

- (void)initialMapSceneLoaded:(WRLDMapView *)mapView
{
    [SamplesMessage showWithMessage:@"Initial map scene loaded"];
}

@end
