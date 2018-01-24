#import "RouteView.h"
#import "SamplesMessage.h"
@import Wrld;
@import WrldWidgets;

@interface RouteView() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) NSMutableArray *m_routeViews;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;

@end


@implementation RouteView
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.460951, -2.980445)
                        zoomLevel:16
                         animated:NO];
    
    [self.view addSubview:_mapView];
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds];
    
    [_indoorControlView setMapView:_mapView];
    
    [self.view addSubview:_indoorControlView];

    
    WRLDRoutingService* wrldRoutingService = [_mapView createRoutingService];
    
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
        for (WRLDRoute* route in routingQueryResponse.results)
        {
            WRLDRouteViewOptions* options = [[[WRLDRouteViewOptions alloc] init] color:[[UIColor redColor] colorWithAlphaComponent:0.5]];
            WRLDRouteView* routeView = [[WRLDRouteView alloc] initWithMapView:mapView route:route options:options];
            [_m_routeViews addObject:(routeView)];
        }
        
        [SamplesMessage showWithMessage:@"Found routes." andDuration:[[NSNumber alloc] initWithInt: 8]];
    }
    else
    {
        [SamplesMessage showWithMessage:@"Routing query failed." andDuration:[[NSNumber alloc] initWithInt: 8]];
    }
}

@end

