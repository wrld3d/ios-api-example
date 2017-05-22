#import "AddCustomIndoorControl.h"
@import Wrld;

@interface AddCustomIndoorControl () <WRLDIndoorMapDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) NSArray<UIButton *> *buttons;

@end

@implementation AddCustomIndoorControl

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.781871, -122.404812)
                        zoomLevel:17
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    NSMutableArray<UIButton *>* buttons = [NSMutableArray array];
    
    [buttons addObject: [self addButton: @"TOP FLOOR" withIndex: 0 andSelector: @selector(topFloorButton)]];
    [buttons addObject: [self addButton: @"MOVE UP" withIndex: 1 andSelector: @selector(moveUpButton)]];
    [buttons addObject: [self addButton: @"MOVE DOWN" withIndex: 2 andSelector: @selector(moveDownButton)]];
    [buttons addObject: [self addButton: @"BOTTOM FLOOR" withIndex: 3 andSelector: @selector(bottomFloorButton)]];
    [buttons addObject: [self addButton: @"EXIT" withIndex: 4 andSelector: @selector(exitButton)]];
    
    _buttons = buttons;
    
    [_mapView setIndoorMapDelegate:self];
}

- (UIButton*) addButton: (NSString*)title withIndex: (NSInteger)index andSelector: (SEL)selector
{
    CGFloat height = 40.0;
    CGFloat spacing = 10.0;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
                   action:selector
         forControlEvents:UIControlEventTouchUpInside];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button setFrame:CGRectMake(0.0, 44.0 + (height+spacing) * index, 125.0, height)];
    [button setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:button];
    [button setEnabled:NO];
    return button;
}

- (void) exitButton
{
    [_mapView exitIndoorMap];
}

- (void) topFloorButton
{
    NSInteger numberOfFloors = [[[_mapView activeIndoorMap] floors] count];
    [_mapView setFloorByIndex:numberOfFloors-1];
}

- (void) bottomFloorButton
{
    [_mapView setFloorByIndex:0];
}

- (void) moveUpButton
{
    [_mapView moveUpFloor];
}

- (void) moveDownButton
{
    [_mapView moveDownFloor];
}

- (void) didEnterIndoorMap
{
    for (UIButton *button in _buttons)
    {
        [button setEnabled:YES];
    }
}

- (void) didExitIndoorMap
{
    for (UIButton *button in _buttons)
    {
        [button setEnabled:NO];
    }
}

@end
