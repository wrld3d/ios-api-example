#import "BlueSphereChangeElevation.h"
@import Wrld;


@interface BlueSphereChangeElevation ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation BlueSphereChangeElevation
{
    NSTimer *myTimer;
    BOOL elevationToggle;
    float initialBlueSphereElevation;
    float alteredBlueSphereElevation;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    elevationToggle = false;
    initialBlueSphereElevation = 0;
    alteredBlueSphereElevation = 45;
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.459721, -2.977541)
                        zoomLevel:18
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDBlueSphere* bluesphere;
    bluesphere = [_mapView blueSphere];
    [bluesphere setEnabled:YES];
    [bluesphere setCoordinate:CLLocationCoordinate2DMake(56.459721, -2.977541)];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                               target:self
                                             selector:@selector(toggleElevation:)
                                             userInfo:bluesphere
                                              repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [myTimer invalidate];
    myTimer = nil;
}

- (void)toggleElevation:(NSTimer *)timer
{
    WRLDBlueSphere* bluesphere = timer.userInfo;
    bluesphere.elevation = elevationToggle ? initialBlueSphereElevation : alteredBlueSphereElevation;
    elevationToggle = !elevationToggle;
}

@end
