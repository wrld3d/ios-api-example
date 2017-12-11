#import "FindIndoorRoute.h"
#import "SamplesMessage.h"
@import Wrld;
@import WrldWidgets;

@interface FindIndoorRoute() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;

@end

@implementation FindIndoorRoute
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;

    // set the center of the map and the zoom level
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.46024, -2.978629)
                        zoomLevel:17
                         animated:NO];

    [self.view addSubview:_mapView];
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds];

    [_indoorControlView setMapView:_mapView];

    [self.view addSubview:_indoorControlView];

    WRLDRoutingService* wrldRoutingService = [_mapView createRoutingService];

    WRLDRoutingQueryOptions* wrldRoutingQueryOptions = [[WRLDRoutingQueryOptions alloc] init];
    [wrldRoutingQueryOptions addIndoorWaypoint:CLLocationCoordinate2DMake(56.46024, -2.978629) forIndoorFloor:0];
    [wrldRoutingQueryOptions addIndoorWaypoint:CLLocationCoordinate2DMake(56.4600344, -2.9783117) forIndoorFloor:2];
    [wrldRoutingService findRoutes:(wrldRoutingQueryOptions)];
}

- (void)mapView:(WRLDMapView *)mapView routingQueryDidComplete:(int)routingQueryId routingQueryResponse:(WRLDRoutingQueryResponse *)routingQueryResponse
{
    if (routingQueryResponse.succeeded && [[routingQueryResponse results] count] > 0)
    {
        for (WRLDRoute* route in routingQueryResponse.results)
        {
            for (WRLDRouteSection* section in route.sections)
            {
                for (WRLDRouteStep* step in section.steps)
                {
                    if (step.pathCount < 2)
                    {
                        continue;
                    }

                    WRLDPolyline* polyline = [WRLDPolyline polylineWithCoordinates:step.path
                                                                             count:step.pathCount
                                                                       onIndoorMap:step.indoorId
                                                                           onFloor:step.indoorFloorId];
                    polyline.color = [[UIColor redColor] colorWithAlphaComponent:0.5];

                    [mapView addOverlay:polyline];
                }
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
