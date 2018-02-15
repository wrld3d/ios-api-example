#import "HighlightIndoorMapEntities.h"
@import Wrld;

@interface HighlightIndoorMapEntities ()

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) NSArray<UIButton *> *buttons;

@end

@implementation HighlightIndoorMapEntities

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.459966, -2.978167)
                        zoomLevel:17
                         animated:NO];

    [self.view addSubview:_mapView];

    NSMutableArray<UIButton *>* buttons = [NSMutableArray array];

    [[self addButton: @"Go to floor" withIndex: 0 andSelector: @selector(goToFloor)] setEnabled:YES];
    [buttons addObject: [self addButton: @"Highlight entities" withIndex: 1 andSelector: @selector(highlightEntities)]];
    [buttons addObject: [self addButton: @"Clear highlights" withIndex: 2 andSelector: @selector(clearEntityHighlights)]];

    _buttons = buttons;

    [self addObservers];
}

- (void) dealloc
{
    if (_mapView)
    {
        [self removeObservers];
    }
}

- (void) addObservers
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(didEnterIndoorMap)
                   name:WRLDMapViewDidEnterIndoorMapNotification object:_mapView];
    [center addObserver:self selector:@selector(didExitIndoorMap)
                   name:WRLDMapViewDidExitIndoorMapNotification object:_mapView];
}

- (void) removeObservers
{
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:WRLDMapViewDidEnterIndoorMapNotification object:_mapView];
    [center removeObserver:self name:WRLDMapViewDidExitIndoorMapNotification object:_mapView];
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

- (void) goToFloor
{
    WRLDMapCamera* camera = [_mapView camera];
    camera.centerCoordinate = CLLocationCoordinate2DMake(56.459966, -2.978167);
    camera.distance = 250;
    camera.indoorMapId = @"westport_house";
    camera.indoorMapFloorId = 2;

    [_mapView setCamera:camera];
}

- (void) highlightEntities
{
    NSString* indoorId = _mapView.activeIndoorMap.indoorId;
    [_mapView setEntityHighlights:indoorId
                     highlightIds:@[@"0007", @"Small Meeting Room"]
                            color:[[UIColor redColor] colorWithAlphaComponent:0.5]];

    [_mapView setEntityHighlights:indoorId
                     highlightIds:@[@"0002", @"Meeting Room"]
                            color:[[UIColor blueColor] colorWithAlphaComponent:0.5]];

    [_mapView setEntityHighlights:indoorId
                     highlightIds:@[@"0033"]
                            color:[[UIColor greenColor] colorWithAlphaComponent:0.5]];
}

- (void) clearEntityHighlights
{
    [_mapView clearAllEntityHighlights];
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
