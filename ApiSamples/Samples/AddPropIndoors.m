#import "AddPropIndoors.h"
@import Wrld;
@import WrldWidgets;


@interface AddPropIndoors ()

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;

@end

@implementation AddPropIndoors

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.782080, -122.404575)
                        zoomLevel:17
                         animated:NO];
    
    [self.view addSubview:_mapView];
    _indoorControlView = [[WRLDIndoorControlView alloc] initWithFrame:self.view.bounds];
    
    [_indoorControlView setMapView:_mapView];
    
    [self.view addSubview:_mapView];
    [self.view addSubview:_indoorControlView];
    
    // the intercontinental hotel in SF has 5 floors. Let's add a prop to each of them.
    const int floorCount = 5;
    for(int floorId = 0; floorId < floorCount; floorId++)
    {
        WRLDProp* prop = [WRLDProp propWithName:[NSString stringWithFormat:@"my_prop_%d", floorId]
                                     geometryId:@"duck"
                                       location:CLLocationCoordinate2DMake(37.782080, -122.404575)
                                    indoorMapId:@"intercontinental_hotel_8628"
                               indoorMapFloorId:floorId
                                      elevation:0
                                  elevationMode:WRLDElevationModeHeightAboveGround
                                 headingDegrees:90.0];

        [_mapView addOverlay:prop];
    }
}

@end
