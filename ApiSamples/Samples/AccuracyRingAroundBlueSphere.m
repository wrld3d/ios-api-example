#import "AccuracyRingAroundBlueSphere.h"
@import Wrld;

@interface AccuracyRingAroundBlueSphere ()
@property (nonatomic) WRLDMapView *mapView;
@end

@implementation AccuracyRingAroundBlueSphere
{
    NSTimer *myTimer;
    BOOL accuracyRingToggle;
    CLLocationCoordinate2D initialBlueSphereLocation;
    float initialAccuracyRingRadius;
    float alteredAccuracyRingRadius;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    accuracyRingToggle = false;
    initialBlueSphereLocation = CLLocationCoordinate2DMake(56.459811, -2.977928);
    initialAccuracyRingRadius = 5;
    alteredAccuracyRingRadius = 10;
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.459721, -2.977541)
                        zoomLevel:18
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDBlueSphere* bluesphere;
    bluesphere = [_mapView blueSphere];
    [bluesphere setEnabled:YES];
    [bluesphere setAccuracyRingEnabled:YES];
    [bluesphere setAccuracyInMeters:initialAccuracyRingRadius];
    [bluesphere setCoordinate:initialBlueSphereLocation];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                               target:self
                                             selector:@selector(toggleLocation:)
                                             userInfo:bluesphere
                                              repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [myTimer invalidate];
    myTimer = nil;
}

- (void)toggleLocation:(NSTimer *)timer
{
    WRLDBlueSphere* bluesphere = timer.userInfo;
    bluesphere.accuracyInMeters = accuracyRingToggle ? initialAccuracyRingRadius : alteredAccuracyRingRadius;
    accuracyRingToggle = !accuracyRingToggle;
}

@end
