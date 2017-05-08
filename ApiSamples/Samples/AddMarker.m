#import "AddMarker.h"
@import Wrld;


@interface AddMarker ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation AddMarker

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)];
    marker.title = @"This is a marker";
    [_mapView addMarker:marker];
}

@end
