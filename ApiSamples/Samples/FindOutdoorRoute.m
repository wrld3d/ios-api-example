#import "FindOutdoorRoute.h"
#import "SamplesMessage.h"
@import Wrld;

@interface FindOutdoorRoute() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation FindOutdoorRoute
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;

    // set the center of the map and the zoom level
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.461062, -2.97977)
                       zoomLevel:17
                        animated:NO];

    [self.view addSubview:_mapView];

    WRLDRoutingService* wrldRoutingService = [_mapView createRoutingService];

    WRLDRoutingQueryOptions* wrldRoutingQueryOptions = [[WRLDRoutingQueryOptions alloc] init];
    [wrldRoutingQueryOptions addWaypoint:CLLocationCoordinate2DMake(56.460918, -2.981560)];
    [wrldRoutingQueryOptions addWaypoint:CLLocationCoordinate2DMake(56.461207, -2.977993)];
    [wrldRoutingService findRoutes:(wrldRoutingQueryOptions)];
}

- (void)mapView:(WRLDMapView *)mapView routingQueryDidComplete:(int)routingQueryId routingQueryResponse:(WRLDRoutingQueryResponse *)routingQueryResponse
{
    if (routingQueryResponse.succeeded && [[routingQueryResponse results] count] > 0)
    {
        [SamplesMessage showWithMessage:@"Found routes." andDuration:[[NSNumber alloc] initWithInt: 8]];
    }
    else
    {
        [SamplesMessage showWithMessage:@"Routing query failed." andDuration:[[NSNumber alloc] initWithInt: 8]];
    }
}

@end
