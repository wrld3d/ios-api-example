// Copyright eeGeo Ltd (2012-2014), All Rights Reserved

#import "EegeoMapsContainerViewController.h"
#import "EGApi.h"
#import "EegeoCustomAnnotationView.h"

@import CoreLocation;

@interface EegeoMapsContainerViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@interface EegeoMapsContainerViewController () <EGMapDelegate>
@property (strong, nonatomic) id<EGMapApi> eegeoMapApi;
@end

@interface EegeoMapsContainerViewController ()
@property (strong, nonatomic) EGMapView* eegeoMapView;
@end

@implementation EegeoMapsContainerViewController
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.eegeoMapApi = nil;
    
    self.eegeoMapView = [[[EGMapView alloc] initWithFrame:self.view.bounds] autorelease];
    self.eegeoMapView.eegeoMapDelegate = self;
    self.eegeoMapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view insertSubview:self.eegeoMapView atIndex:0];
    
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear :animated];
    
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    
    self.eegeoMapApi = nil;
    
    [self.eegeoMapView removeFromSuperview];
    self.eegeoMapView.eegeoMapDelegate = nil;
    self.eegeoMapView = nil;
}

- (void)eegeoMapReady:(id<EGMapApi>)api
{
    self.eegeoMapApi = api;
    
    [self.eegeoMapApi setCenterCoordinate:CLLocationCoordinate2DMake(37.793436, -122.398654)
                           distanceMetres:2000.0
                       orientationDegrees:0.f
                                 animated:NO];
}

@end


