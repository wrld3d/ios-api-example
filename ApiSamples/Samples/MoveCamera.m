#import "MoveCamera.h"
@import Wrld;


@interface MoveCamera ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MoveCamera

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
                                    repeats:FALSE];
}

- (void)onDelay:(NSTimer *)timer
{
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.802, -122.405783)
                        zoomLevel:15
                        direction:90
                         animated:YES];
}

@end
