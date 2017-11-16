#import "Search.h"
#import "SamplesMessage.h"
@import Wrld;
@import WrldWidgets;


@implementation Search
{
    WRLDSearchWidgetView *m_tableView;
    
    WRLDSearchModule* m_searchModule;
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
    
    
    m_tableView = [[WRLDSearchWidgetView alloc ] initWithFrame:CGRectMake(10, 10, 150, 200)];
    [self.view addSubview:m_tableView];
    
    
    m_searchModule = [[WRLDSearchModule alloc] init];
    
    //TODO
    //[m_searchModule addSearchProvider: [[WRLDPoiSearchProvider alloc] initWithMap:mapView]];
    
    [m_tableView setSearchModule:m_searchModule];

    
}

@end

