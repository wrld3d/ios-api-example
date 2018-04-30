#import "PreloadMapData.h"
#import "SamplesMessage.h"
@import Wrld;

@interface PreloadMapData() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation PreloadMapData
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
    
    // precache resources in a 2km radius sphere around the start point
    [_mapView precache:CLLocationCoordinate2DMake(37.7858, -122.401) radius:2000 completionHandler:^(WRLDPrecacheOperationResult* result)
     {
         // A few seconds after starting the example, this message should appear when the
         // precaching has completed.
         NSString* message = [NSString stringWithFormat:@"Precaching %s.", [result succeeded] ? "succeeded" : "failed"];
         [SamplesMessage showWithMessage:message andDuration:[[NSNumber alloc] initWithInt: 6]];
     }];
}

@end

