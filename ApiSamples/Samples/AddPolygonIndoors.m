#import "AddPolygonIndoors.h"
@import Wrld;
@import WrldWidgets;


@interface AddPolygonIndoors ()

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;

@end

@implementation AddPolygonIndoors

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.781895, -122.404433)
                        zoomLevel:17
                         animated:NO];
    
    [self.view addSubview:_mapView];
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds];
    
    [_indoorControlView setMapView:_mapView];
    
    [self.view addSubview:_mapView];
    [self.view addSubview:_indoorControlView];
    
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(37.782279, -122.404588),
        CLLocationCoordinate2DMake(37.782262, -122.404359),
        CLLocationCoordinate2DMake(37.782149, -122.404454),
        CLLocationCoordinate2DMake(37.782207, -122.404541)
    };
   
    
    NSUInteger count = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    
    WRLDPolygon* polygon = [WRLDPolygon polygonWithCoordinates: coordinates
                                                         count: count
                                                   onIndoorMap: @"intercontinental_hotel_8628"
                                                       onFloor: 1];
    
    [_mapView addPolygon:polygon];
}

@end
