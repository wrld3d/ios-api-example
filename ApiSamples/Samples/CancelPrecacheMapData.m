#import "CancelPrecacheMapData.h"
#import "SamplesMessage.h"
@import Wrld;

@interface CancelPrecacheMapData() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation CancelPrecacheMapData
{
 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;
    
    // set the center of the map and the zoom level
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    // Start to precache resources in a 2km radius sphere around the start point
    WRLDPrecacheOperation* precacheOperation =
        [_mapView precache:CLLocationCoordinate2DMake(37.7858, -122.401)
                    radius:2000
         completionHandler:^(WRLDPrecacheOperationResult* result)
     {
         NSString* message = [NSString stringWithFormat:@"Precaching %s", [result succeeded] ? "complete" : "cancelled"];
         [SamplesMessage showWithMessage:message andDuration:[[NSNumber alloc] initWithInt: 6]];
     }];
    // Cancel the precache operation
    [precacheOperation cancel];
}

@end

