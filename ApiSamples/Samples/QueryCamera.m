#import "QueryCamera.h"
#import "SamplesMessage.h"
@import Wrld;


@interface QueryCamera ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation QueryCamera

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];

    [NSTimer scheduledTimerWithTimeInterval:3
                                     target:self
                                   selector:@selector(onDelay:)
                                   userInfo:nil
                                    repeats:NO];
}

- (void)onDelay:(NSTimer *)timer
{
    WRLDMapCamera* camera = _mapView.camera;
    
    NSString *message = [NSString stringWithFormat:@"Camera center coordinate is [%f, %f]; altitude is %f m", camera.centerCoordinate.latitude, camera.centerCoordinate.longitude, camera.altitude];
    
    
    [SamplesMessage showWithMessage:message
                        andDuration:[NSNumber numberWithInt:10]];
    

}



@end
