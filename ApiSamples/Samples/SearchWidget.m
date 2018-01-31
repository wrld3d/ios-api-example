#import "SearchWidget.h"
#import "SamplesMessage.h"

@import Wrld;
@import WrldWidgets;

@implementation SearchWidget
{
    WRLDSearchWidgetView *m_searchWidgetView;
    POIServiceSearchProvider *wrldPoiSearchProvider;
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
    
    wrldPoiSearchProvider = [[POIServiceSearchProvider alloc] initWithMapViewAndPoiService: mapView poiService: [mapView createPoiService]];
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
    {
        m_searchWidgetView = [[WRLDSearchWidgetView alloc ] initWithFrame:CGRectMake(10, 10, 375, 568)];
    }
    else{
        m_searchWidgetView = [[WRLDSearchWidgetView alloc ] initWithFrame:CGRectMake((self.view.bounds.size.width-375)/2.0f, 10, 375, 568)];
    }
    //[m_searchWidgetView setSearchModule:m_searchWidgetViewController];
    [m_searchWidgetView addSearchProvider:wrldPoiSearchProvider];
    
    MockSearchProvider* mockProvider = [[MockSearchProvider alloc] init];
    [m_searchWidgetView addSearchProvider:mockProvider];
    
    NSBundle* widgetsBundle = [NSBundle bundleForClass:[WRLDSearchWidgetView class]];
    
    UINib* yelpNib = [UINib nibWithNibName:@"YelpSearchResultCell" bundle:widgetsBundle];
    
    [m_searchWidgetView registerCellForResultsTable:@"YelpSearchResultCell" :yelpNib];
    
    [self.view addSubview:m_searchWidgetView];
}

@end

