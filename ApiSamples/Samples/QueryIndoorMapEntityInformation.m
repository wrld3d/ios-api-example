#import "QueryIndoorMapEntityInformation.h"
#import "SamplesMessage.h"
@import Wrld;

@interface QueryIndoorMapEntityInformation () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) NSArray<WRLDMarker*> *markers;

@end

@implementation QueryIndoorMapEntityInformation

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    _mapView.delegate = self;

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.459801, -2.977928)
                        zoomLevel:17
                         animated:NO];

    [self.view addSubview:_mapView];
}

- (void)addIndoorMapEntityInformation
{
    WRLDIndoorMapEntityInformation* indoorMapEntityInformation = [WRLDIndoorMapEntityInformation informationForIndoorMap:@"westport_house"];
    [_mapView addIndoorMapEntityInformation:indoorMapEntityInformation];
}

- (void)addMarkers:(WRLDIndoorMapEntityInformation *)indoorMapEntityInformation
{
    [self removeMarkers];
    
    NSMutableArray* markers = [[NSMutableArray alloc] initWithCapacity:[indoorMapEntityInformation.indoorMapEntities count]];
    
    
    for (WRLDIndoorMapEntity* indoorMapEntity in indoorMapEntityInformation.indoorMapEntities) {
        WRLDMarker* marker = [WRLDMarker markerAtCoordinate:indoorMapEntity.coordinate
                              inIndoorMap:indoorMapEntityInformation.indoorMapId
                              onFloor:indoorMapEntity.indoorMapFloorId
                              ];
        marker.title = indoorMapEntity.indoorMapEntityId;
        marker.elevation = 2.0;

        [markers addObject:marker];
    }

    _markers = [markers copy];
    [_mapView addMarkers:markers];
    
}

- (void)removeMarkers
{
    [_mapView removeMarkers:_markers];
    _markers = nil;
}

+ (NSString*)loadStateToString:(WRLDIndoorMapEntityLoadState)loadState
{
    switch (loadState) {
        case WRLDIndoorMapEntityLoadStateNone:
            return @"None";
        case WRLDIndoorMapEntityLoadStatePartial:
            return @"Partial";
        case WRLDIndoorMapEntityLoadStateComplete:
            return @"Complete";
        default:
            break;
    }
    return @"";
}

#pragma mark - WRLDMapViewDelegate implementation

- (void)mapViewDidFinishLoadingInitialMap:(WRLDMapView *)mapView
{
    WRLDMapCamera* camera = [_mapView camera];
    camera.centerCoordinate = CLLocationCoordinate2DMake(56.459976, -2.978015);
    camera.distance = 300;
    camera.indoorMapId = @"westport_house";
    camera.indoorMapFloorId = 2;
    
    [_mapView setCamera:camera];

    [self addIndoorMapEntityInformation];
}

- (void)mapView:(WRLDMapView *)mapView indoorMapEntityInformationDidChange:(WRLDIndoorMapEntityInformation *)indoorMapEntityInformation
{
    [self addMarkers:indoorMapEntityInformation];

    [SamplesMessage showWithMessage:[NSString stringWithFormat:@"WRLDIndoorMapEntityInformation for %@\nload state: %@; entities: %d.",
                                     indoorMapEntityInformation.indoorMapId,
                                     [QueryIndoorMapEntityInformation loadStateToString:indoorMapEntityInformation.loadState],
                                     [indoorMapEntityInformation.indoorMapEntities count]]
                        andDuration:[[NSNumber alloc] initWithInt: 6]];
}
@end
