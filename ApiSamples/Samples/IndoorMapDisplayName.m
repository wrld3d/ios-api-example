#import "IndoorMapDisplayName.h"
#import "SamplesMessage.h"
@import Wrld;


@interface IndoorMapDisplayName ()

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) UIButton *exitButton;

@end

@implementation IndoorMapDisplayName

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.781871, -122.404812)
                        zoomLevel:17
                         animated:NO];
    
    _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_exitButton addTarget:self
                            action:@selector(exitInterior)
                  forControlEvents:UIControlEventTouchUpInside];
    
    [_exitButton setTitle:@"Exit" forState:UIControlStateNormal];
    _exitButton.frame = CGRectMake(3.0, 3.0, 90.0, 50.0);
    _exitButton.backgroundColor = [UIColor lightGrayColor];
    [self enableExitButton:NO];
    [_mapView addSubview:_exitButton];
    
    [self.view addSubview:_mapView];
    
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

- (BOOL) shouldAutorotate
{
    return false;
}

- (void) exitInterior
{
    [_mapView exitIndoorMap];
}

- (void) didEnterIndoorMap
{
    WRLDIndoorMap* indoorMap = _mapView.activeIndoorMap;
    
    NSString *message = [NSString stringWithFormat:@"Entered Indoor Map: '%@'", indoorMap.name];
    [SamplesMessage showWithMessage:message
                        andDuration:[NSNumber numberWithInt:10]];
    
    
    [self enableExitButton:YES];
}

- (void) didExitIndoorMap
{
    [self enableExitButton:NO];
}

- (void) enableExitButton:(BOOL)enabled
{
    [_exitButton setEnabled:YES];
    _exitButton.alpha = enabled ? 1.0 : 0.7;
}

@end
