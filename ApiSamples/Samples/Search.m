#import "Search.h"
#import "SamplesMessage.h"

@import Wrld;
@import WrldWidgets;


@implementation Search
{
    WRLDSearchWidgetView *m_tableView;
    
    WRLDSearchModule* m_searchModule;
    
    WRLDPoiService* m_poiService;
    
    POIServiceSuggestionProvider* m_poiSearchProvider;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WRLDMapView *mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    // set the center of the map and the zoom level
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                       zoomLevel:15
                        animated:NO];
    
    [self.view addSubview:mapView];
    
    
    m_tableView = [[WRLDSearchWidgetView alloc ] initWithFrame:CGRectMake(10, 10, 300, 500)];
    [self.view addSubview:m_tableView];
    
    
    m_searchModule = [[WRLDSearchModule alloc] init];
    
    
    
    m_poiService = [mapView createPoiService];
    
    m_poiSearchProvider = [[POIServiceSuggestionProvider alloc] initWithMapViewAndPoiService: mapView poiService: m_poiService];
    
    
    [m_searchModule addSuggestionProvider: m_poiSearchProvider];
    
    [m_tableView setSearchModule:m_searchModule];
    
    
    [m_searchModule doAutoCompleteQuery: @"Yerba"];
    
}

@end

