#import "PositionViewOnMap.h"
#import "WRLDPositionerDelegate.h"
#import "PositionViewPin.h"
@import Wrld;

@interface PositionViewOnMap_PositionerChangedController : NSObject<WRLDPositionerDelegate>
@property (nonatomic) WRLDPositioner *positioner;
@property (nonatomic) PositionViewPin *calloutView;
@end

@implementation PositionViewOnMap_PositionerChangedController
-(id)initWithPositioner: (WRLDPositioner*)positioner
                   calloutView: (PositionViewPin *)calloutView
{
    _positioner = positioner;
    _calloutView = calloutView;
    return self;
}

- (void) onPositionerChanged: (WRLDPositioner*)positioner
{
    CGPoint *screenPoint = [positioner screenPointOrNull];

    if([positioner screenPointProjectionDefined])
    {
        if(screenPoint != nil)
        {
            CGRect frame = _calloutView.frame;
            frame.origin.x = (screenPoint->x/[UIScreen mainScreen].scale) - 125;
            frame.origin.y = (screenPoint->y/[UIScreen mainScreen].scale) - frame.size.height;
            _calloutView.frame = frame;
        }
        [_calloutView setHidden: false];
    }
    else
    {
        [_calloutView setHidden: true];
    }

    NSString* screenPointText;
    if(screenPoint != nil)
        screenPointText = [NSString stringWithFormat:@"Screen Coordinate X:%d Y:%d",
                           (int)screenPoint->x,
                           (int)screenPoint->y];
    else
        screenPointText = @"Not visible";

    WRLDCoordinateWithAltitude *transformedPoint = [positioner transformedPointOrNull];

    NSString* transformedPointText;
    if(transformedPoint != nil)
        transformedPointText = [NSString stringWithFormat:@"Lat:%.4f Long:%.4f Alt:%.4f",
                                transformedPoint->coordinate.latitude,
                                transformedPoint->coordinate.longitude,
                                transformedPoint->altitude];
    else
        transformedPointText = @"Not visible";

    [_calloutView setDescription: [NSString stringWithFormat:@"%@\n%@",
                                   screenPointText,
                                   transformedPointText]];
}
@end

@interface PositionViewOnMap ()
@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) PositionViewPin *calloutView;
@property (nonatomic) UIButton *buttonView;
@property BOOL mapCollapsed;
-(void) onClickMapCollapse;
@end

@implementation PositionViewOnMap

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapCollapsed = false;

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.802355, -122.405848)
                        zoomLevel:15
                         animated:NO];
    [self.view addSubview:_mapView];
        
    _calloutView = [[PositionViewPin alloc] init];
    _calloutView.frame = CGRectMake(10, 10, 500, 200);
    [_mapView addSubview: _calloutView];

    WRLDPositioner* positioner = [WRLDPositioner positionerAtCoordinate:CLLocationCoordinate2DMake(37.802355, -122.405848)];
    positioner.delegate = [[PositionViewOnMap_PositionerChangedController alloc] initWithPositioner: positioner calloutView: _calloutView];
    [_mapView addPositioner:positioner];
    
    _buttonView = [UIButton buttonWithType:UIButtonTypeCustom];
    [_buttonView.layer setMasksToBounds:YES];
    [_buttonView.layer setCornerRadius:10.0f];
    [_buttonView.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    [_buttonView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_buttonView setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_buttonView setTitle:@"Collapse" forState:UIControlStateNormal];
    [_buttonView setUserInteractionEnabled:YES];
    _buttonView.frame = CGRectMake(10, 10, 150, 60);
    [_buttonView addTarget:self action:@selector(onClickMapCollapse) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _buttonView];
}

-(void) onClickMapCollapse
{
    _mapCollapsed = !_mapCollapsed;
    [_mapView setMapCollapsed:_mapCollapsed];
}

@end
