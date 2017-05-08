#import "BasicMap.h"
#import "SamplesMessage.h"
@import Wrld;


@interface BasicMap ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation BasicMap

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect viewBounds = self.view.bounds;
    
    CGFloat top = 96;
    CGFloat border = 32;
    viewBounds.size.width -= 2*border;
    viewBounds.size.height -= top + border;
    viewBounds.origin.x += border;
    viewBounds.origin.y += top;
    
    _mapView = [[WRLDMapView alloc] initWithFrame:viewBounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    [SamplesMessage showWithMessage:@"Welcome to WRLD maps"];
}

@end
