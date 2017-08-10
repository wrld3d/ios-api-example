#import "PolygonWithElevation.h"
@import Wrld;


@interface PolygonWithElevation ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation PolygonWithElevation

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(55.942953, -3.161405)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(55.945976, -3.162339),
        CLLocationCoordinate2DMake(55.943671, -3.158673),
        CLLocationCoordinate2DMake(55.941648, -3.159911),
        CLLocationCoordinate2DMake(55.943248, -3.163275)
    };
    
    NSUInteger count = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    
    WRLDPolygon* polygon = [WRLDPolygon polygonWithCoordinates:coordinates count:count];
    polygon.color = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    
    WRLDPolygon* polygon2 = [WRLDPolygon polygonWithCoordinates:coordinates count:count];
    
    polygon2.color = [[UIColor redColor] colorWithAlphaComponent:0.5];
    polygon2.elevation = 200;
    
    [_mapView addPolygons:@[polygon, polygon2]];
}

@end
