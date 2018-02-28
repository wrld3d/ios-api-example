#import "SearchWidget.h"
#import "SamplesMessage.h"

@import Wrld;
@import WrldWidgets;
@import WrldSearchWidget;

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
        CGRectMake(20, 20, 375, CGRectGetHeight(self.view.bounds) - 40) :   // ipad
        CGRectMake(10, 10, CGRectGetWidth(self.view.bounds) - 20, CGRectGetHeight(self.view.bounds) - 20); // iphone
    
    WRLDSearchModel* searchModel = [[WRLDSearchModel alloc] init];
    WRLDSearchWidgetViewController* searchWidgetViewController = [[WRLDSearchWidgetViewController alloc] initWithSearchModel:searchModel];
    [self addChildViewController:searchWidgetViewController];
    searchWidgetViewController.view.frame = searchFrame;
    [self.view addSubview: searchWidgetViewController.view];
    
    WRLDMockSearchProvider *mockProvider = [[WRLDMockSearchProvider alloc] init];
    WRLDSearchProviderHandle *mockSearchHandle = [searchModel addSearchProvider:mockProvider];
    WRLDSuggestionProviderHandle *mockSuggestionHandle = [searchModel addSuggestionProvider:mockProvider];
        
    [searchWidgetViewController displaySearchProvider: mockSearchHandle];
    [searchWidgetViewController displaySuggestionProvider: mockSuggestionHandle];
        
    WRLDPoiServiceSearchProvider * wrldPoiSearchProvider = [[WRLDPoiServiceSearchProvider alloc] initWithMapViewAndPoiService: mapView poiService: [mapView createPoiService]];
    WRLDSearchProviderHandle *poiSearchHandle = [searchModel addSearchProvider:wrldPoiSearchProvider];
    WRLDSuggestionProviderHandle *poiSuggestionHandle = [searchModel addSuggestionProvider:wrldPoiSearchProvider];
    
    [searchWidgetViewController displaySearchProvider: poiSearchHandle];
    [searchWidgetViewController displaySuggestionProvider: poiSuggestionHandle];
}

@end

