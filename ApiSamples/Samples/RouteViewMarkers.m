#import "RouteViewMarkers.h"
#import "SamplesMessage.h"
@import Wrld;
@import WrldWidgets;

@interface RouteViewMarkers() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) NSMutableArray *m_routeViews;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;
@property (nonatomic) WRLDPointOnPathService *pointOnPathService;

@end


@implementation RouteViewMarkers
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.461062, -2.97977)
                        zoomLevel:17
                         animated:NO];
    
    [self.view addSubview:_mapView];
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds];
    
    [_indoorControlView setMapView:_mapView];
    
    [self.view addSubview:_indoorControlView];
    
    WRLDRoutingService* wrldRoutingService = [_mapView createRoutingService];
    
    _pointOnPathService = [_mapView createPointOnPathService];
    
    WRLDRoutingQueryOptions* wrldRoutingQueryOptions = [[WRLDRoutingQueryOptions alloc] init];
    [wrldRoutingQueryOptions addIndoorWaypoint:CLLocationCoordinate2DMake(56.461231653264029, -2.983122836389253) forIndoorFloor:2];
    [wrldRoutingQueryOptions addIndoorWaypoint:CLLocationCoordinate2DMake(56.4600344, -2.9783117) forIndoorFloor:2];
    [wrldRoutingService findRoutes:(wrldRoutingQueryOptions)];
    
    _m_routeViews = [[NSMutableArray alloc] init];
}

- (void)mapView:(WRLDMapView *)mapView routingQueryDidComplete:(int)routingQueryId routingQueryResponse:(WRLDRoutingQueryResponse *)routingQueryResponse
{
    if (routingQueryResponse.succeeded && [[routingQueryResponse results] count] > 0)
    {
        CLLocationCoordinate2D testCoordinate = CLLocationCoordinate2DMake(56.460469, -2.980330);
        WRLDMarker* targetMarker = [WRLDMarker markerAtCoordinate:testCoordinate];
        targetMarker.title = @"Target Marker";
        [mapView addMarker:targetMarker];
    
        for (WRLDRoute* route in routingQueryResponse.results)
        {
            WRLDRouteViewOptions* options = [[[WRLDRouteViewOptions alloc] init] color:[[UIColor redColor] colorWithAlphaComponent:0.5]];
            WRLDRouteView* routeView = [[WRLDRouteView alloc] initWithMapView:mapView route:route options:options];
            [_m_routeViews addObject:(routeView)];
            
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
            
            WRLDPointOnRoute* pointOnRouteInfo = [_pointOnPathService getPointOnRoute:route point:testCoordinate];
            
            if(pointOnRouteInfo != nil)
            {
                WRLDMarker* pointOnRouteMarker = [WRLDMarker markerAtCoordinate:pointOnRouteInfo.resultPoint];
                pointOnRouteMarker.title = [NSString stringWithFormat:@"R: %f, S: %f, St: %f", pointOnRouteInfo.fractionAlongRoute, pointOnRouteInfo.fractionAlongRouteSection, pointOnRouteInfo.fractionAlongRouteStep];
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


