#import "BlueSphereChangeDirection.h"
@import Wrld;


@interface BlueSphereChangeDirection ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation BlueSphereChangeDirection
{
    NSTimer *myTimer;
    float direction;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.459721, -2.977541)
                        zoomLevel:18
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDBlueSphere* bluesphere;
    bluesphere = [_mapView blueSphere];
    [bluesphere setEnabled:YES];
    [bluesphere setCoordinate:CLLocationCoordinate2DMake(56.459721, -2.977541)
                    direction:0];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                               target:self
                                             selector:@selector(rotateBlueSphere:)
                                             userInfo:bluesphere
                                              repeats:YES];
}

- (void)rotateBlueSphere:(NSTimer *)timer
{
    WRLDBlueSphere* bluesphere = timer.userInfo;
    bluesphere.direction += 45;
}

@end
