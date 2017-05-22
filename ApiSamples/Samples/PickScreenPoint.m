#import "PickScreenPoint.h"
#import "SamplesMessage.h"
@import Wrld;


@interface PickScreenPoint ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation PickScreenPoint

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
}




@end
