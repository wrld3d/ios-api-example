#import "SetThemeManifest.h"
#import "SamplesMessage.h"
@import Wrld;

@implementation SetThemeManifest

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // See https://github.com/wrld3d/wrld-themes for current manifest options
    NSString *themeManifest = @"http://cdn-resources.wrld3d.com/mobile-themes-new/v1151/legacy/manifest.bin.gz";
    WRLDMapOptions *mapOptions = [[WRLDMapOptions alloc] init];
    mapOptions.environmentThemesManifest = themeManifest;
    WRLDMapView *mapView = [[WRLDMapView alloc] initWithFrame:self.view.bounds andMapOptions:mapOptions];
    
    mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(37.7858, -122.401)
                       zoomLevel:15
                        animated:NO];
    
    [self.view addSubview:mapView];
    
    NSString *message= [NSString stringWithFormat:@"Set manifest to %@.", themeManifest];
    [SamplesMessage showWithMessage:message andDuration:[NSNumber numberWithInt:10]];
}

@end
