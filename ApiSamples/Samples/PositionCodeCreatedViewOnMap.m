#import "PositionCodeCreatedViewOnMap.h"
#import "WRLDPositionerDelegate.h"
#import "PositionerCallout.h"
@import Wrld;

@interface PositionCodeCreatedViewOnMap_PositionerChangedController : NSObject<WRLDPositionerDelegate>
@property (nonatomic) WRLDPositioner *positioner;
@property (nonatomic) UIView *view;
@end

@implementation PositionCodeCreatedViewOnMap_PositionerChangedController
-(id)initWithPositioner: (WRLDPositioner*)positioner
                   view: (UIView *)view
{
    _positioner = positioner;
    _view = view;
    return self;
}

- (void) onPositionerChanged: (WRLDPositioner*)positioner
{
    if([positioner screenPointProjectionDefined])
    {
        CGPoint *screenPoint = [positioner screenPointOrNull];
        if(screenPoint != nil)
        {
            float anchorU = 0.5f;
            float anchorV = 0.5f;
            
            CGRect frame = _view.frame;
            frame.origin.x = (screenPoint->x/[UIScreen mainScreen].scale) - (frame.size.width*anchorU);
            frame.origin.y = (screenPoint->y/[UIScreen mainScreen].scale) - (frame.size.height*anchorV);
            _view.frame = frame;
        }
        [_view setHidden: false];
    }
    else
    {
        [_view setHidden: true];
    }
}
@end

@interface PositionCodeCreatedViewOnMap ()
@property (nonatomic) WRLDMapView *mapView;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *collapseButton;
@property BOOL mapCollapsed;
-(void) onClickMapCollapse;
@end

@implementation PositionCodeCreatedViewOnMap

- (void)viewDidLoad
{
    [super viewDidLoad];

    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.802355, -122.405848)
                        zoomLevel:15
                         animated:NO];
    [self.view addSubview:_mapView];

    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrld3d.png"]];
    [_mapView addSubview: _imageView];

    WRLDPositioner* positioner = [WRLDPositioner positionerAtCoordinate:CLLocationCoordinate2DMake(37.802355, -122.405848)];
    positioner.delegate = [[PositionCodeCreatedViewOnMap_PositionerChangedController alloc]
                           initWithPositioner: positioner
                           view: _imageView];
    [_mapView addPositioner:positioner];

    _collapseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collapseButton.layer setMasksToBounds:YES];
    [_collapseButton.layer setCornerRadius:10.0f];
    [_collapseButton.layer setBackgroundColor:[UIColor whiteColor].CGColor];
    [_collapseButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_collapseButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_collapseButton setTitle:@"Collapse" forState:UIControlStateNormal];
    [_collapseButton setUserInteractionEnabled:YES];
    _collapseButton.frame = CGRectMake(10, 10, 150, 60);
    [_collapseButton addTarget:self action:@selector(onClickMapCollapse) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview: _collapseButton];
}

-(void) onClickMapCollapse
{
    _mapCollapsed = !_mapCollapsed;
    [_mapView setMapCollapsed:_mapCollapsed];
}

@end
