#import "SearchExample.h"
#import "SamplesMessage.h"
@import Wrld;

@interface SearchExample() <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation SearchExample
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
    [textSearchOptions setQuery: @"free"];
    [textSearchOptions setCenter:  [_mapView centerCoordinate] ];
    [textSearchOptions setRadius: 1000.0];
    [textSearchOptions setNumber: 60];
    [wrldPoiService searchText: textSearchOptions];
    
    WRLDTagSearchOptions* tagSearchOptions = [[WRLDTagSearchOptions alloc] init];
    [tagSearchOptions setQuery: @"coffee"];
    [tagSearchOptions setCenter:  [_mapView centerCoordinate] ];
    [wrldPoiService searchTag: tagSearchOptions];
    
    WRLDAutocompleteOptions* autocompleteOptions = [[WRLDAutocompleteOptions alloc] init];
    [autocompleteOptions setQuery: @"auto"];
    [autocompleteOptions setCenter:  [_mapView centerCoordinate] ];
    [wrldPoiService searchAutocomplete: autocompleteOptions];
}

- (void)mapView:(WRLDMapView *)mapView poiSearchDidComplete: (int) poiSearchId
poiSearchResponse: (WRLDPoiSearchResponse*) poiSearchResponse
{

    if([poiSearchResponse succeeded] && [[poiSearchResponse results] count] > 0)
    {
    
        // Icon/Tag mapping, see:
        // https://github.com/wrld3d/wrld-icon-tools/blob/master/data/search_tags.json
        NSDictionary* iconKeyTagDict = @{
            @"park" : @"park",
            @"coffee" : @"coffee",
            @"general" : @"misc"
        };
    
        for(WRLDPoiSearchResult *searchResult in [poiSearchResponse results])
        {
            WRLDMarker* marker = [WRLDMarker markerAtCoordinate:[searchResult latLng]];
            marker.title = [searchResult title];
            marker.iconKey = @"misc";
            
            for (id tag in [[searchResult tags] componentsSeparatedByString: @" "])
            {
                if([iconKeyTagDict objectForKey: tag])
                {
                    marker.iconKey = iconKeyTagDict[tag];
                }
            }
            
            [_mapView addMarker:marker];
        }
    }
    else
    {
        m_failedSearches++;
        
        if(m_failedSearches >= 3)
        {
            [SamplesMessage showWithMessage:@"No POIs found; Visit https://mapdesigner.wrld3d.com/poi/latest/ to create some POIs." andDuration:[[NSNumber alloc] initWithInt: 99999]];
        }
    }

}

@end
