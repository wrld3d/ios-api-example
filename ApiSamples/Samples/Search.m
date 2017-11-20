#import "Search.h"
#import "SamplesMessage.h"

@import Wrld;
@import WrldWidgets;

@implementation Search
{
    WRLDSearchWidgetView *m_searchWidgetView;
    WRLDSearchModule *m_searchModule;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WRLDMapView *mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                       zoomLevel:15
                        animated:NO];
    [self.view addSubview:mapView];
    
    m_searchModule = [[WRLDSearchModule alloc] init];
    [m_searchModule addSearchProvider: [[POIServiceSearchProvider alloc] initWithMapViewAndPoiService: mapView poiService: [mapView createPoiService]]];
    
    m_searchWidgetView = [[WRLDSearchWidgetView alloc ] initWithFrame:CGRectMake(10, 10, 300, 500)];
    [m_searchWidgetView setSearchModule:m_searchModule];
    [m_searchWidgetView setMapView:mapView];
    [self.view addSubview:m_searchWidgetView];
}

@end

