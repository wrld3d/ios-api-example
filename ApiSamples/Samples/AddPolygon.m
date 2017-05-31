#import "AddPolygon.h"
@import Wrld;


@interface AddPolygon ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation AddPolygon

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7900, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(37.786617, -122.404654),
        CLLocationCoordinate2DMake(37.797843, -122.407057),
        CLLocationCoordinate2DMake(37.798962, -122.398260),
        CLLocationCoordinate2DMake(37.794299, -122.395234)
    };
    
    NSUInteger count = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    
    WRLDPolygon* polygon = [WRLDPolygon polygonWithCoordinates:coordinates count:count];
    
    [_mapView addPolygon:polygon];
}

@end
