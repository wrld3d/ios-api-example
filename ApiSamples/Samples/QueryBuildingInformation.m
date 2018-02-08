#import "QueryBuildingInformation.h"
#import "SamplesMessage.h"
@import Wrld;

@interface QueryBuildingInformation() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation QueryBuildingInformation
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;

    // set the center of the map and the zoom level
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.784079, -122.396762)
                        zoomLevel:18
                         animated:NO];

    [self.view addSubview:_mapView];


}

- (void)mapViewDidFinishLoadingInitialMap:(WRLDMapView *)mapView
{
    // create building highlight options
    WRLDBuildingHighlightOptions* buildingHighlightOptions = [WRLDBuildingHighlightOptions highlightOptionsWithLocation:CLLocationCoordinate2DMake(37.784079, -122.396762)];
    [buildingHighlightOptions informationOnly];
    
    WRLDBuildingHighlight* buildingHighlight = [WRLDBuildingHighlight highlightWithOptions:buildingHighlightOptions];
    [_mapView addBuildingHighlight:buildingHighlight];
}

- (void)mapView:(WRLDMapView *)mapView didReceiveBuildingInformationForHighlight:(WRLDBuildingHighlight *)buildingHighlight
{
    WRLDBuildingInformation* buildingInformation = [buildingHighlight buildingInformation];
    if (buildingInformation == nil) {
        [SamplesMessage showWithMessage:@"No building information was received for building highlight." andDuration:[[NSNumber alloc] initWithInt: 6]];
        return;
    }

    [SamplesMessage showWithMessage:[buildingInformation buildingId] andDuration:[[NSNumber alloc] initWithInt: 6]];

    WRLDBuildingDimensions* buildingDimensions = [buildingInformation buildingDimensions];
    CLLocationDistance buildingHeight = [buildingDimensions topAltitude] - [buildingDimensions baseAltitude];

    WRLDMarker* marker = [WRLDMarker markerAtCoordinate:[buildingDimensions centroid]];
    marker.title = [NSString stringWithFormat:@"Height: %1$.2f m", buildingHeight];
    marker.elevation = [buildingDimensions topAltitude];
    marker.elevationMode = WRLDElevationModeHeightAboveSeaLevel;
    [_mapView addMarker:marker];

    for (WRLDBuildingContour* contour in buildingInformation.contours)
    {
        CLLocationCoordinate2D coordinates[contour.pointCount+1];

        [contour getPoints:coordinates];
        coordinates[contour.pointCount] = coordinates[0];

        WRLDPolyline* polyline = [WRLDPolyline polylineWithCoordinates:coordinates count:contour.pointCount+1];
        polyline.elevationMode = WRLDElevationModeHeightAboveSeaLevel;
        polyline.elevation = [contour topAltitude];
        polyline.color = [UIColor blueColor];

        [_mapView addOverlay:polyline];
    }
}

@end
