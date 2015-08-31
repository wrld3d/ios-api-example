// Copyright eeGeo Ltd (2012-2014), All Rights Reserved

#import "GoogleMapsContainerViewController.h"

@import CoreLocation;
@import GoogleMaps;

@interface GoogleMapsContainerViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@interface GoogleMapsContainerViewController ()
@property (strong, nonatomic) GMSMapView* mapView;

@property (strong, nonatomic) GMSPolygon* geoFencePoly;

@property (strong, nonatomic) GMSMarker* marker1;
@property (strong, nonatomic) GMSMarker* marker2;
@property (strong, nonatomic) GMSMarker* marker3;
@end

@implementation GoogleMapsContainerViewController
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [GMSServices provideAPIKey:@"AIzaSyDOKF3C4Vxvw3wvqjvBX3MM2QUj-PC2B4k"];
    
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
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.793436
                                                            longitude:-122.398654
                                                                 zoom:6];
    
    self.mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    self.mapView.myLocationEnabled = YES;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view insertSubview:self.mapView atIndex:0];
    
    [self handleMapAvailable];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    
    self.marker1.map = nil;
    self.marker1.map = nil;
    self.marker1.map = nil;
    self.marker1 = nil;
    self.marker2 = nil;
    self.marker3 = nil;
    
    self.geoFencePoly.map = nil;
    self.geoFencePoly = nil;
    
    [self.mapView removeFromSuperview];
    self.mapView = nil;
}

-(void)goHome
{
    [self setLocation:YES];
}

-(void)fitToDefaultBounds
{
    [self setCoordinateBounds];
}

- (void)handleMapAvailable
{
    [self setLocation:NO];
    [self addGeofencePolygon];
    [self addAnnotations];
}

- (void)setLocation:(BOOL)animated
{
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.793436
                                                            longitude:-122.398654
                                                                 zoom:16
                                                              bearing:0.f
                                                         viewingAngle:45.f];
    
    if(animated)
    {
        [self.mapView animateToCameraPosition:camera];
    }
    else
    {
        [self.mapView setCamera:camera];
    }
}

-(void)setCoordinateBounds
{
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(37.797818, -122.407015),
        CLLocationCoordinate2DMake(37.798886, -122.398238),
        CLLocationCoordinate2DMake(37.798547, -122.397831),
        CLLocationCoordinate2DMake(37.795482, -122.396736),
        CLLocationCoordinate2DMake(37.794159, -122.395116),
        CLLocationCoordinate2DMake(37.786647, -122.404697)
    };
    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    
    GMSCoordinateBounds *bounds = [[[GMSCoordinateBounds alloc] init] autorelease];
    
    for(int i = 0; i < numberOfCoordinates; ++ i) {
        bounds = [bounds includingCoordinate:coordinates[i]];
    }
    
    [self.mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:0.0f]];
}

-(void) addGeofencePolygon
{
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(37.797818, -122.407015),
        CLLocationCoordinate2DMake(37.798886, -122.398238),
        CLLocationCoordinate2DMake(37.798547, -122.397831),
        CLLocationCoordinate2DMake(37.795482, -122.396736),
        CLLocationCoordinate2DMake(37.794159, -122.395116),
        CLLocationCoordinate2DMake(37.786647, -122.404697)
    };
    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    
    GMSMutablePath *poly = [GMSMutablePath path];
    
    for(int i = 0; i < numberOfCoordinates; ++ i) {
        [poly addCoordinate:coordinates[i]];
    }
    
    self.geoFencePoly = [GMSPolygon polygonWithPath:poly];
    self.geoFencePoly.fillColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.2f];
    self.geoFencePoly.strokeWidth = 0;
    self.geoFencePoly.map = self.mapView;
}

- (void)addAnnotations
{
    self.marker1 = [[[GMSMarker alloc] init] autorelease];
    self.marker1.position = CLLocationCoordinate2DMake(37.794851, -122.402650);
    self.marker1.map = self.mapView;
    
    // Set data after adding Annotation to test KVO.
    self.marker1.title = @"Downtown";
    self.marker1.snippet = @"(Custom Annotation)";
    self.marker1.icon = [UIImage imageNamed:@"custom_annotation_image"];
    
    self.marker2 = [[[GMSMarker alloc] init] autorelease];
    self.marker2.position = CLLocationCoordinate2DMake(37.792064, -122.403784);
    self.marker2.title = @"California Street";
    self.marker2.snippet = @"(Default Callout)";
    self.marker2.map = self.mapView;
    
    self.marker3 = [[[GMSMarker alloc] init] autorelease];
    self.marker3.position = CLLocationCoordinate2DMake(37.795141, -122.397669);
    self.marker3.title = @"Three Embarcadero";
    self.marker3.snippet = @"(Default Callout)";
    self.marker3.map = self.mapView;
    
    // Test programmatic selection.
    self.mapView.selectedMarker = self.marker1;
    self.mapView.selectedMarker = self.marker3;
}

@end


