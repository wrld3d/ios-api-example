#import "CancelRoutingQuery.h"
#import "SamplesMessage.h"
@import Wrld;

@interface CancelRoutingQuery() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation CancelRoutingQuery
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

    WRLDRoutingQuery* routingQuery = [wrldRoutingService findRoutes:(wrldRoutingQueryOptions)];
    [routingQuery cancel];
    [SamplesMessage showWithMessage:@"Query cancelled." andDuration:[[NSNumber alloc] initWithInt: 6]];
}

- (void)mapView:(WRLDMapView *)mapView routingQueryDidComplete:(int)routingQueryId routingQueryResponse:(WRLDRoutingQueryResponse *)routingQueryResponse
{
    //Query is cancelled and never completes
    [SamplesMessage showWithMessage:@"This Message should not be shown." andDuration:[[NSNumber alloc] initWithInt: 6]];
}

@end
