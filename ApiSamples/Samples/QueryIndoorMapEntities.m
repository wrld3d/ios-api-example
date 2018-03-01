#import "QueryIndoorMapEntities.h"
@import Wrld;

@interface QueryIndoorMapEntities () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) NSArray<UIColor*> *colors;
@property (nonatomic) NSMutableDictionary *entityIdsToColorIndex;
@property (nonatomic) UIButton *exitIndoorsButton;
@end

@implementation QueryIndoorMapEntities

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];

    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;

    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.459966, -2.978167)
                        zoomLevel:17
                         animated:NO];

    [self.view addSubview:_mapView];

    [self addButton: @"Go to floor" withIndex: 0 andSelector: @selector(goToFloor)];
    _exitIndoorsButton = [self addButton: @"Exit Interior" withIndex: 1 andSelector: @selector(exitIndoorMap)];
    [_exitIndoorsButton setEnabled:NO];
    
    _colors = [[NSArray alloc] initWithObjects:[[UIColor redColor] colorWithAlphaComponent:0.5],
                                               [[UIColor blueColor] colorWithAlphaComponent:0.5],
                                               [[UIColor greenColor] colorWithAlphaComponent:0.5],
                                               nil];

    _entityIdsToColorIndex = [[NSMutableDictionary alloc] init];
    
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
    [button setEnabled:YES];
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

- (void) exitIndoorMap
{
    [_mapView exitIndoorMap];
}

- (void) didEnterIndoorMap
{
    [_exitIndoorsButton setEnabled:YES];
}

- (void) didExitIndoorMap
{
    [_exitIndoorsButton setEnabled:NO];
}

- (UIColor*) colorForIndoorEntity:(NSString*)indoorEntityId
{
    NSNumber *colorIndex = [_entityIdsToColorIndex objectForKey:indoorEntityId];
    NSUInteger index = colorIndex == nil ? 0 : (colorIndex.unsignedIntegerValue + 1) % [_colors count];
    [_entityIdsToColorIndex setValue:[NSNumber numberWithUnsignedInteger:index] forKey:indoorEntityId];
    return [_colors objectAtIndex:index];
}

#pragma mark - WRLDMapViewDelegate implementation

- (void)mapView:(WRLDMapView *)mapView didTapIndoorEntities:(WRLDIndoorEntityTapResult *)indoorEntityTapResult
{
    if (_mapView.activeIndoorMap != nil)
    {
        [mapView setIndoorEntityHighlights:indoorEntityTapResult.indoorMapId
                           indoorEntityIds:indoorEntityTapResult.indoorEntityIds
                                     color:[self colorForIndoorEntity:indoorEntityTapResult.indoorEntityIds[0]]];
    }
}

@end
