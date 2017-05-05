#import "MapSceneLoadedNotification.h"
#import "SamplesMessage.h"
@import Wrld;

@interface MapSceneLoadedNotification () <WRLDMapViewDelegate>

@end

@implementation MapSceneLoadedNotification

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WRLDMapView *mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    mapView.delegate = self;
    
    [self.view addSubview:mapView];
}

#pragma mark - AppMapViewDelegate implementation

-(void)initialMapSceneLoaded:(WRLDMapView *)mapView
{
    [SamplesMessage showWithMessage:@"Initial map scene loaded"];
}

@end
