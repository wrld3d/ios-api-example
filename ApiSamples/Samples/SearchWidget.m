#import "SearchWidget.h"
#import "SamplesMessage.h"

@import Wrld;
@import WrldWidgets;

@implementation SearchWidget

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WRLDMapView *mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                       zoomLevel:15
                        animated:NO];
    [self.view addSubview:mapView];
    
    
    CGRect searchFrame = ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) ?
        CGRectMake(10, 10, 375, 568) :
        CGRectMake((self.view.bounds.size.width-375)/2.0f, 10, 375, 568);
    
    WRLDSearchWidgetViewController* searchWidgetViewController = [[WRLDSearchWidgetViewController alloc] initWithFrame:searchFrame];
    
//    POIServiceSearchProvider * wrldPoiSearchProvider = [[POIServiceSearchProvider alloc] initWithMapViewAndPoiService: mapView poiService: [mapView createPoiService]];
//    [m_searchWidgetViewController addSearchProvider:wrldPoiSearchProvider];
//
//    MockSearchProvider* mockProvider = [[MockSearchProvider alloc] init];
//    [m_searchWidgetViewController addSearchProvider:mockProvider];
//
//    NSBundle* widgetsBundle = [NSBundle bundleForClass:[WRLDSearchWidgetView class]];
//
//    UINib* yelpNib = [UINib nibWithNibName:@"YelpSearchResultCell" bundle:widgetsBundle];
//
//    [m_searchWidgetViewController registerCellForResultsTable:@"YelpSearchResultCell" :yelpNib];
    
    [self.view addSubview: searchWidgetViewController.rootView];
}

@end

