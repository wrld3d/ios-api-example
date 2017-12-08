#import "LoadMapsceneExample.h"
#import "SamplesMessage.h"
@import Wrld;

@interface LoadMapsceneExample() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation LoadMapsceneExample
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
    
    WRLDMapsceneService* wrldMapsceneService = [_mapView createMapsceneService];
    WRLDMapsceneRequest* MapsceneRequest = [[WRLDMapsceneRequest alloc] init];
    
    MapsceneRequest = [wrldMapsceneService RequestMapscene:[[WRLDMapsceneRequestOptions alloc] initMapsceneRequestOptions:@"https://wrld.mp/63fcc9b" :true]];
    
}

- (void)mapView:(WRLDMapView *)mapView mapsceneResponse:(WRLDMapsceneRequestResponse*)mapsceneResponse
{
    
    if([mapsceneResponse getSucceeded])
    {
        NSString* message = [NSString stringWithFormat:@"Mapscene %@ loaded", [[mapsceneResponse getMapscene] getName]];
        
        [SamplesMessage showWithMessage:message andDuration:[[NSNumber alloc] initWithInt: 8]];
    }
    else
    {
        [SamplesMessage showWithMessage:@"Failed to load mapscene" andDuration:[[NSNumber alloc] initWithInt: 8]];
    }
    
}

@end
