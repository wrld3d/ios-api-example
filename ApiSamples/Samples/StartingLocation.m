#import "StartingLocation.h"
@import Wrld;


@interface StartingLocation () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation StartingLocation

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_mapView];
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.703492, -74.013961)];
}

@end
