#import "SearchWidget.h"
#import "SamplesMessage.h"
#import <CoreLocation/CoreLocation.h>
@import Wrld;
@import WrldWidgets;
@import WrldSearchWidget;

typedef NS_ENUM(NSInteger, MenuOptionType)
{
    CategorySearch,
    LocationJump
};

@interface MenuOptionContext : NSObject

@property MenuOptionType optionType;

@property NSString* text;

@property CLLocationCoordinate2D location;

- (instancetype)initWithOptionType:(MenuOptionType)optionType
                              text:(NSString *)text
                          location:(CLLocationCoordinate2D)location;

@end

@implementation MenuOptionContext

- (instancetype)initWithOptionType:(MenuOptionType)optionType
                              text:(NSString *)text
                          location:(CLLocationCoordinate2D)location
{
    self = [super init];
    if (self)
    {
        _optionType = optionType;
        _text = text;
        _location = location;
    }
    return self;
}

@end

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
    
    WRLDSearchMenuModel* menuModel = [[WRLDSearchMenuModel alloc] init];
    
    WRLDSearchModel* searchModel = [[WRLDSearchModel alloc] init];
    WRLDSearchWidgetViewController* searchWidgetViewController = [[WRLDSearchWidgetViewController alloc] initWithSearchModel:searchModel menuModel:menuModel];
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
    
    [searchWidgetViewController enableVoiceSearch:@"Say something!"];
    
    menuModel.title = @"Menu";
    
    WRLDMenuGroup* groupA = [[WRLDMenuGroup alloc] initWithTitle:@"Show me the closest..."];
    [groupA addOption:@"B&B" context:nil];
    [groupA addOption:@"Hotel" context:nil];
    [groupA addOption:@"Pub" context:nil];
    [groupA addOption:@"Restaurant" context:nil];
    [groupA addOption:@"Youth Hostel" context:nil];
    
    WRLDMenuGroup* groupB = [[WRLDMenuGroup alloc] init];
    WRLDMenuOption* optionA = [[WRLDMenuOption alloc] initWithText:@"City Locations" context:nil];
    [optionA addChild:@"Bangkok" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"Bangkok" location:CLLocationCoordinate2DMake(13.747348, 100.533493)]];
    [optionA addChild:@"Chicago" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"Chicago" location:CLLocationCoordinate2DMake(41.882276, -87.629201)]];
    [optionA addChild:@"Dundee" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"Dundee" location:CLLocationCoordinate2DMake(56.458598, -2.969868)]];
    [optionA addChild:@"Edinburgh" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"Edinburgh" location:CLLocationCoordinate2DMake(55.948991, -3.199949)]];
    [optionA addChild:@"London" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"London" location:CLLocationCoordinate2DMake(51.51122, -0.081494)]];
    [optionA addChild:@"Milan" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"Milan" location:CLLocationCoordinate2DMake(45.474097, 9.177512)]];
    [optionA addChild:@"New York" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"Oslo" location:CLLocationCoordinate2DMake(40.710184, -74.012957)]];
    [optionA addChild:@"New York" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"Oslo" location:CLLocationCoordinate2DMake(59.907757, 10.752348)]];
    [optionA addChild:@"San Francisco" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"San Francisco" location:CLLocationCoordinate2DMake(37.791592, -122.39937)]];
    [optionA addChild:@"Vancouver" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"Vancouver" location:CLLocationCoordinate2DMake(49.289009, -123.125933)]];
    [groupB addOption:optionA];
    
    WRLDMenuOption* optionB = [[WRLDMenuOption alloc] initWithText:@"Your Most Frequented Pubs" context:nil];
    [optionB addChild:@"Dukes" icon:nil context:[[MenuOptionContext alloc] initWithOptionType:LocationJump text:@"Dukes" location:CLLocationCoordinate2DMake(56.4600653,-2.9964554)]];
    [groupB addOption:optionB];
    
    WRLDMenuGroup* groupC = [[WRLDMenuGroup alloc] init];
    [groupC addOption:@"Options" context:nil];
    [groupC addOption:@"About" context:nil];
    
    [menuModel addMenuGroup:groupA];
    [menuModel addMenuGroup:groupB];
    [menuModel addMenuGroup:groupC];
    
    [searchWidgetViewController.menuObserver addOptionSelectedEvent:^(NSObject* context)
     {
         MenuOptionContext* selectedOptionContext = (MenuOptionContext *)context;
         
         switch (selectedOptionContext.optionType)
         {
             case CategorySearch:
             {
                 break;
             }
             case LocationJump:
             {
                 [mapView setCenterCoordinate:selectedOptionContext.location
                                    zoomLevel:15
                                     animated:NO];
                 break;
             }
             default: break;
         }
     }];
}

@end
