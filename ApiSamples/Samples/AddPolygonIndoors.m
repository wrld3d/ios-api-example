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
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.782084, -122.404578)
                        zoomLevel:17
                         animated:NO];
    
    [self.view addSubview:_mapView];
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds];
    
    [_indoorControlView setMapView:_mapView];
    
    [self.view addSubview:_mapView];
    [self.view addSubview:_indoorControlView];

    // the intercontinental hotel in SF has 5 floors. Let's add a polygon to each of them.
    const int floorCount = 5;
    for(int floorIndex = 0; floorIndex < floorCount; floorIndex++)
    {
        CLLocationCoordinate2D exteriorCoordinates[] = {
            CLLocationCoordinate2DMake(37.782084, -122.404578),
            CLLocationCoordinate2DMake(37.782126, -122.404530),
            CLLocationCoordinate2DMake(37.782057, -122.404440),
            CLLocationCoordinate2DMake(37.782012, -122.404491)
        };
        
        WRLDPolygon* polygon = [WRLDPolygon polygonWithCoordinates: exteriorCoordinates
                                                             count: sizeof(exteriorCoordinates) / sizeof(CLLocationCoordinate2D)
                                                       onIndoorMap: @"intercontinental_hotel_8628"
                                                           onFloor: floorIndex];
        
        [_mapView addPolygon:polygon];
    }
}

@end
