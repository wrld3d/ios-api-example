#import "AddIndoorControl.h"
@import Wrld;
@import WrldWidgets;


@interface AddIndoorControl ()

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;

@end

@implementation AddIndoorControl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.4599662, -2.9781313)
                        zoomLevel:17
                         animated:NO];
    
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds];
    [_indoorControlView setMapView:_mapView];
    
    [self.view addSubview:_mapView];
    [self.view addSubview:_indoorControlView];
}

@end
