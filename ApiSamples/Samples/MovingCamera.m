#import "MovingCamera.h"
@import Wrld;


@interface MovingCamera () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MovingCamera

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_mapView];
    
    [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(onDelay:)
                                   userInfo:nil
                                    repeats:FALSE];
}

- (void) onDelay:(NSTimer *) timer {
    const double latitude = 37.802;
    const double longitude = -122.405783;
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latitude, longitude);
    
    [_mapView setCenterCoordinate:coord
                         animated:true];
}

@end
