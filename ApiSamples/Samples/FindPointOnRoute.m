#import "FindPointOnRoute.h"
#import "SamplesMessage.h"
@import Wrld;
@import WrldWidgets;

@interface FindPointOnRoute() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) NSMutableArray *routeViews;
@property (nonatomic) WRLDPointOnPath *pointOnPath;

@end


@implementation FindPointOnRoute
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.460456, -2.979657)
                        zoomLevel:18.5
                        direction:30
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDRoutingService* wrldRoutingService = [_mapView createRoutingService];
    
    _pointOnPath = [_mapView createPointOnPath];
    
    WRLDRoutingQueryOptions* wrldRoutingQueryOptions = [[WRLDRoutingQueryOptions alloc] init];
    [wrldRoutingQueryOptions addIndoorWaypoint:CLLocationCoordinate2DMake(56.461231653264029, -2.983122836389253) forIndoorFloor:2];
    [wrldRoutingQueryOptions addIndoorWaypoint:CLLocationCoordinate2DMake(56.4600344, -2.9783117) forIndoorFloor:2];
    [wrldRoutingService findRoutes:(wrldRoutingQueryOptions)];
    
    _routeViews = [[NSMutableArray alloc] init];
}

- (void)mapView:(WRLDMapView *)mapView routingQueryDidComplete:(int)routingQueryId routingQueryResponse:(WRLDRoutingQueryResponse *)routingQueryResponse
{
    if (routingQueryResponse.succeeded && [[routingQueryResponse results] count] > 0)
    {
        CLLocationCoordinate2D testCoordinate = CLLocationCoordinate2DMake(56.460369, -2.980330);
        WRLDMarker* targetMarker = [WRLDMarker markerAtCoordinate:testCoordinate];
        targetMarker.title = @"Target Marker";
        [mapView addMarker:targetMarker];
        
        for (WRLDRoute* route in routingQueryResponse.results)
        {
            WRLDRouteViewOptions* options = [[[WRLDRouteViewOptions alloc] init] color:[[UIColor redColor] colorWithAlphaComponent:0.5]];
            WRLDRouteView* routeView = [[WRLDRouteView alloc] initWithMapView:mapView route:route options:options];
            [_routeViews addObject:(routeView)];
            
            for (WRLDRouteSection* section in route.sections)
            {
                for (WRLDRouteStep* step in section.steps)
                {
                    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:*(step.path)];
                    if (step.isIndoors)
                    {
                        marker = [WRLDMarker markerAtCoordinate:*(step.path) inIndoorMap:step.indoorId onFloor:step.indoorFloorId];
                    }
                    [mapView addMarker:marker];
                }
            }
            
            WRLDPointOnRouteOptions* pointOnRouteOptions = [[WRLDPointOnRouteOptions alloc] init];
            WRLDPointOnRouteResult* pointOnRouteInfo = [_pointOnPath getPointOnRoute:route point:testCoordinate options:pointOnRouteOptions];
            
            if(pointOnRouteInfo != nil)
            {
                WRLDMarker* pointOnRouteMarker = [WRLDMarker markerAtCoordinate:pointOnRouteInfo.resultPoint];
                pointOnRouteMarker.title = [NSString stringWithFormat:@"Result Point: \n fractionAlongRoute: %f", pointOnRouteInfo.fractionAlongRoute];
                [mapView addMarker:pointOnRouteMarker];
            }
            else
            {
                [SamplesMessage showWithMessage:@"No viable closest-point on route found." andDuration:[[NSNumber alloc] initWithInt: 8]];
            }
        }
        
        [SamplesMessage showWithMessage:@"Found routes." andDuration:[[NSNumber alloc] initWithInt: 8]];
    }
    else
    {
        [SamplesMessage showWithMessage:@"Routing query failed." andDuration:[[NSNumber alloc] initWithInt: 8]];
    }
}

@end


