// Copyright eeGeo Ltd (2012-2014), All Rights Reserved

#import "AppleMapsContainerViewController.h"
#import "AppleCustomAnnotationView.h"

@import MapKit;
@import CoreLocation;

@interface AppleMapsContainerViewController () <CLLocationManagerDelegate>
@property (strong, nonatomic) CLLocationManager *locationManager;
@end

@interface AppleMapsContainerViewController () <MKMapViewDelegate>
@end

@interface AppleMapsContainerViewController ()
@property (strong, nonatomic) MKMapView* mapView;

@property (strong, nonatomic) MKPolygon* geoFencePoly;

@property (strong, nonatomic) MKPointAnnotation* marker1;
@property (strong, nonatomic) MKPointAnnotation* marker2;
@property (strong, nonatomic) MKPointAnnotation* marker3;
@end

@implementation AppleMapsContainerViewController
{
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.geoFencePoly = nil;
    self.marker1 = nil;
    self.marker2 = nil;
    self.marker3 = nil;
    
    self.locationManager = [[[CLLocationManager alloc] init] autorelease];
    
    self.mapView = (MKMapView*)self.view;
    self.mapView.delegate = self;
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear :animated];
    
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    
    [self handleMapAvailable];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    
    self.locationManager.delegate = nil;
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    
    [self.mapView removeAnnotation: self.marker1];
    [self.mapView removeAnnotation: self.marker2];
    [self.mapView removeAnnotation: self.marker3];
    self.marker1 = nil;
    self.marker2 = nil;
    self.marker3 = nil;
    
    [self.mapView removeOverlay:self.geoFencePoly];
    self.geoFencePoly = nil;
    
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
    MKMapCamera* camera = [[[MKMapCamera alloc] init] autorelease];
    camera.centerCoordinate =CLLocationCoordinate2DMake(37.793436, -122.398654);
    camera.heading = 0.f;
    camera.pitch = 45.f;
    camera.altitude = 2000.f;
    
    [self.mapView setCamera:camera animated:animated];
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
    
    MKMapPoint mapPoints[numberOfCoordinates];
    
    for(size_t i = 0; i < numberOfCoordinates; ++ i)
    {
        mapPoints[i] = MKMapPointForCoordinate(coordinates[i]);
    }
    
    MKMapRect mapRect = [[MKPolygon polygonWithPoints:mapPoints count:numberOfCoordinates] boundingMapRect];
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    
    [self.mapView setRegion:region animated:YES];
}

- (void)addGeofencePolygon
{
    //https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/AnnotatingMaps/AnnotatingMaps.html#//apple_ref/doc/uid/TP40009497-CH6-SW6
    
    CLLocationCoordinate2D coordinates[] = {
        CLLocationCoordinate2DMake(37.797818, -122.407015),
        CLLocationCoordinate2DMake(37.798886, -122.398238),
        CLLocationCoordinate2DMake(37.798547, -122.397831),
        CLLocationCoordinate2DMake(37.795482, -122.396736),
        CLLocationCoordinate2DMake(37.794159, -122.395116),
        CLLocationCoordinate2DMake(37.786647, -122.404697)
    };
    NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
    
    self.geoFencePoly = [MKPolygon polygonWithCoordinates:coordinates count:numberOfCoordinates];
    
    [self.mapView addOverlay:self.geoFencePoly];
}

- (void)addAnnotations
{
    self.marker1 = [[[MKPointAnnotation alloc] init] autorelease];
    self.marker1.coordinate = CLLocationCoordinate2DMake(37.794851, -122.402650);
    [self.mapView addAnnotation:self.marker1];
    
    // Set data after adding Annotation to test KVO.
    self.marker1.title = @"Downtown";
    self.marker1.subtitle = @"(Custom Annotation)";
    
    self.marker2 = [[[MKPointAnnotation alloc] init] autorelease];
    self.marker2.coordinate = CLLocationCoordinate2DMake(37.792064, -122.403784);
    self.marker2.title = @"California Street";
    self.marker2.subtitle = @"(Default Callout)";
    [self.mapView addAnnotation:self.marker2];
    
    self.marker3 = [[[MKPointAnnotation alloc] init] autorelease];
    self.marker3.coordinate = CLLocationCoordinate2DMake(37.795141, -122.397669);
    self.marker3.title = @"Three Embarcadero";
    self.marker3.subtitle = @"(Default Callout)";
    [self.mapView addAnnotation:self.marker3];
    
    // Test programmatic selection.
    [self.mapView selectAnnotation:self.marker1 animated:NO];
    [self.mapView selectAnnotation:self.marker3 animated:NO];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation;
{
    // Custom view for marker one that always shows data, no callout as always showing data.
    if(annotation == self.marker1)
    {
        // XIB defined in app, code-behind extends EGAnnotationView.
        AppleCustomAnnotationView* pCustomView = [[[NSBundle mainBundle]
                                                   loadNibNamed:@"AppleCustomAnnotationView"
                                                   owner:self
                                                   options:nil] lastObject];
        
        // Manually (re)bind the annotation, intially nil for custom view.
        [pCustomView initWithAnnotation:annotation reuseIdentifier:@""];
        pCustomView.imageView.image = [UIImage imageNamed:@"custom_annotation_image"];
        
        pCustomView.centerOffset = CGPointMake(-pCustomView.frame.size.width * 0.5f,
                                               -pCustomView.frame.size.height);
        
        pCustomView.canShowCallout = NO;
        
        return pCustomView;
    }
    
    // For other pins use default view.
    return nil;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    printf("Selected annotation with title: %s\n", [[view.annotation title] UTF8String]);
    
    // Add a nice left callout accessory.
    view.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view
{
    // Remove the left callout accessory.
    view.leftCalloutAccessoryView = nil;
    
    printf("Deselected annotation with title: %s\n", [[view.annotation title] UTF8String]);
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    //https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/LocationAwarenessPG/AnnotatingMaps/AnnotatingMaps.html#//apple_ref/doc/uid/TP40009497-CH6-SW6
    
    if ([overlay isKindOfClass:[MKPolygon class]])
    {
        MKPolygonRenderer* aRenderer = [[[MKPolygonRenderer alloc] initWithPolygon:(MKPolygon*)overlay] autorelease];
        
        aRenderer.fillColor = [UIColor colorWithRed:1.f green:0.0f blue:0.0f alpha:0.2f];
        aRenderer.lineWidth = 0;
        
        return aRenderer;
    }
    
    return nil;
}

@end


