#import "AnimateCamera.h"
@import Wrld;


@interface AnimateCamera () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation AnimateCamera

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_mapView];

    WRLDMapCamera* camera = [WRLDMapCamera cameraLookingAtCenterCoordinate:CLLocationCoordinate2DMake(37.802, -122.405783) fromDistance:1000 pitch:30 heading:270];
    [_mapView setCamera:camera duration:5];
}

@end
