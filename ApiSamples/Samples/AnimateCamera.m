#import "AnimateCamera.h"
@import Wrld;


@interface AnimateCamera ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation AnimateCamera

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    [NSTimer scheduledTimerWithTimeInterval:3
                                     target:self
                                   selector:@selector(onDelay:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)onDelay:(NSTimer *)timer
{
    WRLDMapCamera* camera = [WRLDMapCamera cameraLookingAtCenterCoordinate:CLLocationCoordinate2DMake(37.802, -122.4058) fromDistance:500 pitch:30 heading:270];
    [_mapView setCamera:camera duration:5];
}

@end
