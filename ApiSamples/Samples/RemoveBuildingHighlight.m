#import "RemoveBuildingHighlight.h"
@import Wrld;

@interface RemoveBuildingHighlight() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation RemoveBuildingHighlight
{
    NSTimer *highlightTimer;
    WRLDBuildingHighlight* buildingHighlight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;

    // set the center of the map and the zoom level
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.795189, -122.402777)
                        zoomLevel:16
                         animated:NO];

    [self.view addSubview:_mapView];
}


- (void)mapViewDidFinishLoadingInitialMap:(WRLDMapView *)mapView
{
    // create building highlight options
    WRLDBuildingHighlightOptions* buildingHighlightOptions = [WRLDBuildingHighlightOptions highlightOptionsWithLocation:CLLocationCoordinate2DMake(37.795189, -122.402777)];
    [buildingHighlightOptions setColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5]];
    
    highlightTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                                      target:self
                                                    selector:@selector(toggleBuildingHighlight:)
                                                    userInfo:buildingHighlightOptions
                                                     repeats:YES];
}

- (void)toggleBuildingHighlight:(NSTimer *)timer
{
    WRLDBuildingHighlightOptions* buildingHighlightOptions = timer.userInfo;

    if (buildingHighlight == nil)
    {
        buildingHighlight = [WRLDBuildingHighlight highlightWithOptions:buildingHighlightOptions];
        [_mapView addBuildingHighlight:buildingHighlight];
    }
    else
    {
        [_mapView removeBuildingHighlight:buildingHighlight];
        buildingHighlight = nil;
    }
}

@end
