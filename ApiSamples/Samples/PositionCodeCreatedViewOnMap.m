#import "PositionCodeCreatedViewOnMap.h"
#import "WRLDMapViewDelegate.h"
#import "PositionerCallout.h"
#import "WRLDViewAnchor.h"
@import Wrld;

@interface PositionCodeCreatedViewOnMap () <WRLDMapViewDelegate>
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
    
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];

    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrld3d.png"]];
    [_mapView addSubview: _imageView];

    WRLDPositioner *positioner = [WRLDPositioner positionerAtCoordinate:CLLocationCoordinate2DMake(37.802355, -122.405848)];
    [_mapView addPositioner:positioner];

    _collapseButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_collapseButton addTarget:self action:@selector(onClickMapCollapse) forControlEvents:UIControlEventTouchUpInside];
    [_collapseButton setTitle:@"Collapse" forState:UIControlStateNormal];
    _collapseButton.frame = CGRectMake(10, 10, 150, 60);
    _collapseButton.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_collapseButton];
}

-(void) onClickMapCollapse
{
    _mapCollapsed = !_mapCollapsed;
    [_mapView setMapCollapsed:_mapCollapsed];
}

- (void)mapView:(WRLDMapView *)mapView positionerDidChange: (WRLDPositioner*)positioner
{
    if([positioner screenPointProjectionDefined])
    {
        CGPoint *screenPoint = [positioner screenPointOrNull];
        if(screenPoint != nil)
        {
            CGPoint anchorUV = CGPointMake(0.5f, 0.5f);            
            [WRLDViewAnchor positionView:_imageView screenPoint:screenPoint anchorUV:&anchorUV];
        }
        [_imageView setHidden: false];
    }
    else
    {
        [_imageView setHidden: true];
    }
}

@end
