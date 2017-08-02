#import "BlueSphereIndoors.h"
@import Wrld;
@import WrldWidgets;

@interface BlueSphereIndoors ()

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;

@end

@implementation BlueSphereIndoors
{
    NSTimer *myTimer;
    BOOL locationToggle;
    CLLocationCoordinate2D initialBlueSphereLocation;
    CLLocationCoordinate2D alteredBlueSphereLocation;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationToggle = false;
    initialBlueSphereLocation = CLLocationCoordinate2DMake(56.460017, -2.978245);
    alteredBlueSphereLocation = CLLocationCoordinate2DMake(56.459943, -2.978216);
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.459721, -2.977541)
                        zoomLevel:18
                         animated:NO];
    
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds];
    [_indoorControlView setMapView:_mapView];
    
    [self.view addSubview:_mapView];
    [self.view addSubview:_indoorControlView];
    
    WRLDBlueSphere* bluesphere;
    bluesphere = [_mapView blueSphere];
    [bluesphere setEnabled:YES];
    [bluesphere setCoordinate:initialBlueSphereLocation];
    [bluesphere setIndoorMap:@"westport_house" withIndoorMapFloorId:2];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                               target:self
                                             selector:@selector(toggleLocation:)
                                             userInfo:bluesphere
                                              repeats:YES];
}

- (void)toggleLocation:(NSTimer *)timer
{
    WRLDBlueSphere* bluesphere = timer.userInfo;
    bluesphere.coordinate = locationToggle ? initialBlueSphereLocation : alteredBlueSphereLocation;
    locationToggle = !locationToggle;
}

@end
