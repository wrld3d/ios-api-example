#import "AddBuildingHighlight.h"
@import Wrld;

@interface AddBuildingHighlight() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation AddBuildingHighlight
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

    // create building highlight options
    WRLDBuildingHighlightOptions* buildingHighlightOptions = [[WRLDBuildingHighlightOptions alloc] init];
    [buildingHighlightOptions highlightBuildingAtLocation:CLLocationCoordinate2DMake(37.795189, -122.402777)];
    [buildingHighlightOptions setColor:[[UIColor yellowColor] colorWithAlphaComponent:0.5]];

    [_mapView addBuildingHighlight:buildingHighlightOptions];
}

@end
