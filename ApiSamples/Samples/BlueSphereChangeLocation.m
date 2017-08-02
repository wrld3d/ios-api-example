#import "BlueSphereChangeLocation.h"
@import Wrld;


@interface BlueSphereChangeLocation ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation BlueSphereChangeLocation
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
    initialBlueSphereLocation = CLLocationCoordinate2DMake(56.459811, -2.977928);
    alteredBlueSphereLocation = CLLocationCoordinate2DMake(56.459675, -2.977205);
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.459721, -2.977541)
                        zoomLevel:18
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDBlueSphere* bluesphere;
    bluesphere = [_mapView blueSphere];
    [bluesphere setEnabled:YES];
    [bluesphere setCoordinate:initialBlueSphereLocation];
    
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
