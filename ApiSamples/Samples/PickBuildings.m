#import "PickBuildings.h"
#import "SamplesMessage.h"
@import Wrld;

@interface PickBuildings() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation PickBuildings
{
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

- (void)removeHighlight:(NSTimer *)timer
{
    WRLDBuildingHighlight* buildingHighlight = timer.userInfo;
    [_mapView removeBuildingHighlight:buildingHighlight];
}

#pragma mark - WRLDMapViewDelegate implementation

- (void)mapView:(WRLDMapView *)mapView didTapView:(WRLDTouchTapInfo)tapInfo
{
    WRLDPickResult* pickResult = [_mapView pickFeatureAtScreenPoint:tapInfo.screenPoint];

    NSString* message = [NSString stringWithFormat:@"Picked map feature: %@", WRLDMapFeatureTypeToString(pickResult.mapFeatureType)];
    [SamplesMessage showWithMessage:message andDuration:[[NSNumber alloc] initWithInt: 3]];

    if (pickResult.mapFeatureType == WRLDFeatureTypeBuilding)
    {
        WRLDBuildingHighlightOptions* buildingHighlightOptions = [WRLDBuildingHighlightOptions highlightOptionsWithScreenPoint:tapInfo.screenPoint];
        [buildingHighlightOptions setColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5]];

        WRLDBuildingHighlight* buildingHighlight = [WRLDBuildingHighlight highlightWithOptions:buildingHighlightOptions];
        [_mapView addBuildingHighlight:buildingHighlight];

        [NSTimer scheduledTimerWithTimeInterval:3
                                         target:self
                                       selector:@selector(removeHighlight:)
                                       userInfo:buildingHighlight
                                        repeats:NO];
    }
}

@end

