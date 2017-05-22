#import "ExitIndoorMap.h"
@import Wrld;
@import WrldWidgets;


@interface ExitIndoorMap () <WRLDIndoorMapDelegate>

@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) WRLDIndoorControlView *indoorControlView;
@property (nonatomic) UIButton *exitInteriorButton;

@end

@implementation ExitIndoorMap

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(56.4599662, -2.9781313)
                        zoomLevel:17
                         animated:NO];
    
    _exitInteriorButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_exitInteriorButton addTarget:self
                            action:@selector(exitInterior)
                  forControlEvents:UIControlEventTouchUpInside];
    
    [_exitInteriorButton setTitle:@"Exit" forState:UIControlStateNormal];
    _exitInteriorButton.frame = CGRectMake(3.0, 3.0, 90.0, 50.0);
    _exitInteriorButton.backgroundColor = [UIColor lightGrayColor];
    [_exitInteriorButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5] forState:UIControlStateNormal];
    [_mapView addSubview:_exitInteriorButton];
    
    [self.view addSubview:_mapView];
    [self.view addSubview:_indoorControlView];
    
    [_mapView setIndoorMapDelegate:self];
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
    [_exitInteriorButton setEnabled:YES];
    [_exitInteriorButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] forState:UIControlStateNormal];
}

- (void) didExitIndoorMap
{
    [_exitInteriorButton setEnabled:NO];
    [_exitInteriorButton setTitleColor:[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.5] forState:UIControlStateNormal];
}

@end
