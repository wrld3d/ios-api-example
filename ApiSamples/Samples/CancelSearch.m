#import "CancelSearch.h"
#import "SamplesMessage.h"
@import Wrld;

@interface CancelSearch() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation CancelSearch
{
    int m_failedSearches;
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
    
    m_failedSearches = 0;
    
    WRLDPoiService* wrldPoiService = [_mapView createPoiService];
    
    WRLDTextSearchOptions* textSearchOptions = [[WRLDTextSearchOptions alloc] init];
    [textSearchOptions setQuery: @"poi"];
    [textSearchOptions setCenter:  [_mapView centerCoordinate] ];
    [textSearchOptions setRadius: 1000.0];
    [textSearchOptions setNumber: 60];
    WRLDPoiSearch* search = [wrldPoiService searchText: textSearchOptions];
    
    [search cancel];
    [SamplesMessage showWithMessage:@"Search cancelled." andDuration:[[NSNumber alloc] initWithInt: 6]];
}

- (void)mapView:(WRLDMapView *)mapView poiSearchDidComplete: (int) poiSearchId
poiSearchResponse: (WRLDPoiSearchResponse*) poiSearchResponse
{
    //Search is cancelled and never completes
    [SamplesMessage showWithMessage:@"This Message should not be shown." andDuration:[[NSNumber alloc] initWithInt: 6]];
}

@end

