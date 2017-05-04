#import "MoveCamera.h"
@import Wrld;


@interface MoveCamera () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MoveCamera

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_mapView];
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(37.802, -122.405783);
    
    [_mapView setCenterCoordinate:coord
                        zoomLevel:15
                        direction:90
                         animated:YES];
}

@end
