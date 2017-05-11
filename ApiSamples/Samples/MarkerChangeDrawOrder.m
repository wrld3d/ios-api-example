#import "MarkerChangeDrawOrder.h"
@import Wrld;


@interface MarkerChangeDrawOrder ()

@property (nonatomic) WRLDMapView *mapView;

@end

@implementation MarkerChangeDrawOrder
{
    NSTimer *myTimer;
    BOOL drawOrderToggle;
    NSInteger highPriorityDrawOrder;
    NSInteger midPriorityDrawOrder;
    NSInteger lowPriorityDrawOrder;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    highPriorityDrawOrder = 0;
    midPriorityDrawOrder = 1;
    lowPriorityDrawOrder = 2;
    drawOrderToggle = NO;
    
    _mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds];
    
    _mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                        zoomLevel:15
                         animated:NO];
    
    [self.view addSubview:_mapView];
    
    WRLDMarker *markerA = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(37.784560, -122.402256)];
    markerA.title = @"Marker A";
    markerA.drawOrder = midPriorityDrawOrder;
    
    WRLDMarker *markerB = [WRLDMarker markerAtCoordinate:CLLocationCoordinate2DMake(37.784560, -122.402016)];
    markerB.title = @"Marker B";
    markerB.drawOrder = lowPriorityDrawOrder;
    
    [_mapView addMarkers:@[markerA, markerB]];
    
    myTimer = [NSTimer scheduledTimerWithTimeInterval:2
                                               target:self
                                             selector:@selector(toggleDrawOrder:)
                                             userInfo:markerB
                                              repeats:YES];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [myTimer invalidate];
    myTimer = nil;
}

- (void)toggleDrawOrder:(NSTimer *)timer
{
    WRLDMarker* marker = timer.userInfo;
    drawOrderToggle = !drawOrderToggle;
    marker.drawOrder = drawOrderToggle ? highPriorityDrawOrder : lowPriorityDrawOrder;
}

@end
