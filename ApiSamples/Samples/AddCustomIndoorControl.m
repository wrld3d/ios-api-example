#import "AddCustomIndoorControl.h"
@import Wrld;
@import WrldWidgets;


@interface AddCustomIndoorControl ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation AddCustomIndoorControl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.4599662, -2.9781313)
                        zoomLevel:17
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    [self addButton: @"Exit Indoor Map" withIndex: 0 andSelector: @selector(exitIndoorMap)];
    [self addButton: @"Go Up One Floor" withIndex: 1 andSelector: @selector(moveUpOneFloor)];
    [self addButton: @"Go Down Floor" withIndex: 2 andSelector: @selector(moveDownOneFloor)];
    [self addButton: @"Go To Lowest Floor" withIndex: 3 andSelector: @selector(goToLowestFloor)];
}

- (void) addButton: (NSString*)title withIndex: (NSInteger)index andSelector: (SEL)selector
{
    CGFloat height = 50.0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
                   action:selector
         forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0.0, 100.0 + height * index, 250.0, height)];
    [button setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:button];
}

- (void) exitIndoorMap
{
    [_mapView exitIndoorMap];
}

- (void) goToLowestFloor
{
    [_mapView setFloorByIndex:0];
}

- (void) moveUpOneFloor
{
    [_mapView moveUpFloor];
}

- (void) moveDownOneFloor
{
    [_mapView moveDownFloor];
}

@end
