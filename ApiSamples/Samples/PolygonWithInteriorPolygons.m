#import "PolygonWithInteriorPolygons.h"
@import Wrld;


@interface PolygonWithInteriorPolygons ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation PolygonWithInteriorPolygons

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7900, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    CLLocationCoordinate2D interiorCoordinates1[] = {
        CLLocationCoordinate2DMake(37.795168, -122.402665),
        CLLocationCoordinate2DMake(37.792300, -122.403781),
        CLLocationCoordinate2DMake(37.792656, -122.400420)
    };
    
    NSUInteger count = sizeof(interiorCoordinates1) / sizeof(CLLocationCoordinate2D);
    WRLDPolygon *interiorPolygon1 = [WRLDPolygon polygonWithCoordinates:interiorCoordinates1 count:3];
    
    CLLocationCoordinate2D interiorCoordinates2[] = {
        CLLocationCoordinate2DMake(37.790979, -122.403028),
        CLLocationCoordinate2DMake(37.790404, -122.401272),
        CLLocationCoordinate2DMake(37.788705, -122.402579),
        CLLocationCoordinate2DMake(37.789706, -122.403516)
    };
    
    count = sizeof(interiorCoordinates2) / sizeof(CLLocationCoordinate2D);
    WRLDPolygon *interiorPolygon2 = [WRLDPolygon polygonWithCoordinates:interiorCoordinates2 count:4];
    
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(37.786617, -122.404654),
        CLLocationCoordinate2DMake(37.797843, -122.407057),
        CLLocationCoordinate2DMake(37.798962, -122.398260),
        CLLocationCoordinate2DMake(37.794299, -122.395234)
    };
    
    count = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    WRLDPolygon* polygon = [WRLDPolygon polygonWithCoordinates:coordinates
                                                         count:count
                                              interiorPolygons:@[interiorPolygon1, interiorPolygon2]];
    
    polygon.color = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    
    [_mapView addPolygon:polygon];
}

@end
