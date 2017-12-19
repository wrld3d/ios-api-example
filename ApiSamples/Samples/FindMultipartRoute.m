#import "FindMultipartRoute.h"
#import "SamplesMessage.h"
@import Wrld;
@import WrldWidgets;

@interface FindMultipartRoute() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;

@end

@implementation FindMultipartRoute
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;

    // set the center of the map and the zoom level
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.4600344, -2.9783117)
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

                    WRLDPolyline* polyline;

                    if (step.isIndoors)
                    {
                        polyline = [WRLDPolyline polylineWithCoordinates:step.path
                                                                   count:step.pathCount
                                                             onIndoorMap:step.indoorId
                                                                 onFloor:step.indoorFloorId];
                    }
                    else
                    {
                        polyline = [WRLDPolyline polylineWithCoordinates:step.path
                                                                   count:step.pathCount];
                    }
                    
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
