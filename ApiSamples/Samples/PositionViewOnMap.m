#import "PositionViewOnMap.h"
#import "PositionerCallout.h"
@import Wrld;

@interface PositionViewOnMap () <WRLDMapViewDelegate>

@property (nonatomic) WRLDMapView *mapView;

@property (nonatomic) PositionerCallout *calloutView;
@property (nonatomic) WRLDPositioner *positioner;

@property (nonatomic) UIButton *collapseButton;
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
    
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
        
    _calloutView = [[PositionerCallout alloc] init];
    
    double dominantAxis = self.view.bounds.size.height;
    
    if(self.view.bounds.size.width > self.view.bounds.size.height)
    {
        dominantAxis = self.view.bounds.size.width;
    }
    
    double scaleFactor = MAX(0.6, MIN((dominantAxis * 0.5) / 500, 1.0));
    
    _calloutView.frame = CGRectMake(10, 10, 500 * scaleFactor, 170 * scaleFactor);
    [_mapView addSubview: _calloutView];

    _positioner = [WRLDPositioner positionerAtCoordinate:CLLocationCoordinate2DMake(37.802355, -122.405848)];
    [_mapView addPositioner:_positioner];
    
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

#pragma mark - WRLDMapViewDelegate implementation

- (void)mapView:(WRLDMapView *)mapView positionerDidChange: (WRLDPositioner*)positioner
{
    CGPoint *screenPoint = [positioner screenPointOrNull];

    if([positioner screenPointProjectionDefined])
    {
        if(screenPoint != nil)
        {
            CGPoint anchorUV = CGPointMake(0.0f, 1.0f);
            [WRLDViewAnchor positionView:_calloutView screenPoint:screenPoint anchorUV:&anchorUV];
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
