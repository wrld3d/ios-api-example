#import "FindPointOnPath.h"
#import "SamplesMessage.h"
@import Wrld;
@import WrldWidgets;

@interface FindPointOnPath() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) WRLDPointOnPath *pointOnPath;

@end


@implementation FindPointOnPath
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.460456, -2.979657)
                        zoomLevel:18
                        direction:30
                         animated:NO];
    
    [self.view addSubview:_mapView];

    
    _pointOnPath = [_mapView createPointOnPath];
    
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(56.459866, -2.980015),
        CLLocationCoordinate2DMake(56.459727, -2.979299),
        CLLocationCoordinate2DMake(56.461067, -2.979750),
        CLLocationCoordinate2DMake(56.461017, -2.980325)
    };

    CLLocationCoordinate2D targetCoordinate = CLLocationCoordinate2DMake(56.460369, -2.980330);
    WRLDMarker* targetMarker = [WRLDMarker markerAtCoordinate:targetCoordinate];
    targetMarker.title = @"Target Marker";
    [_mapView addMarker:targetMarker];
    
    NSInteger coordinateCount = 4;
    
    WRLDPointOnPathResult* pointOnPathResult = [_pointOnPath getPointOnPath:coordinates count:coordinateCount point:targetCoordinate];
    
    WRLDMarker* pointOnRouteMarker = [WRLDMarker markerAtCoordinate:pointOnPathResult.resultPoint];
    pointOnRouteMarker.title = [NSString stringWithFormat:@"Result Point \n fractionAlongPath: %f", pointOnPathResult.fractionAlongPath];
    [_mapView addMarker:pointOnRouteMarker];
    
    NSUInteger count = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    
    WRLDPolyline* polyline = [WRLDPolyline polylineWithCoordinates:coordinates count:count];
    polyline.color = [[UIColor redColor] colorWithAlphaComponent:0.5];
    
    [_mapView addOverlay:polyline];
}

@end


