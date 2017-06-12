#import "InitialStreamingCompleteNotification.h"
#import "SamplesMessage.h"
@import Wrld;


@interface InitialStreamingCompleteNotification () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation InitialStreamingCompleteNotification

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
}

#pragma mark - WRLDMapViewDelegate implementation

- (void)mapViewDidFinishLoadingInitialMap:(WRLDMapView *)mapView
{
    [SamplesMessage showWithMessage:@"Initial map streaming completed"];
}

@end
