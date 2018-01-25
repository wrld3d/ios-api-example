#import "MoveCameraToIndoor.h"
@import Wrld;


@interface MoveCameraToIndoor () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) UIButton *exitButton;

@end

@implementation MoveCameraToIndoor

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _mapView.delegate = self;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.781871, -122.404812)
                        zoomLevel:16
                         animated:NO];
    
    _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_exitButton addTarget:self
                    action:@selector(exitInterior)
          forControlEvents:UIControlEventTouchUpInside];
    
    [_exitButton setTitle:@"Exit" forState:UIControlStateNormal];
    _exitButton.frame = CGRectMake(3.0, 3.0, 90.0, 50.0);
    _exitButton.backgroundColor = [UIColor lightGrayColor];
    [self enableExitButton:NO];
    
    
    [self.view addSubview:_mapView];
    
    [self.view addSubview:_exitButton];
    
    [self addObservers];
}

- (void)mapViewDidFinishLoadingInitialMap:(WRLDMapView *)mapView
{
    WRLDMapCamera* camera = [_mapView camera];
    camera.centerCoordinate = CLLocationCoordinate2DMake(37.782332,  -122.404667);
    camera.distance = 300;
    camera.heading = 270;
    camera.indoorMapId = @"intercontinental_hotel_8628";
    camera.indoorMapFloorId = 2;
    
    [_mapView setCamera:camera];
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

