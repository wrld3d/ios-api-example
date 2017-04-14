// Copyright eeGeo Ltd (2012-2014), All Rights Reserved

#import "EegeoMapsContainerViewController.h"
#import "EGApi.h"

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
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear :animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:(BOOL)animated];
    
    self.eegeoMapApi = nil;
    
    [self.eegeoMapView removeFromSuperview];
    self.eegeoMapView.eegeoMapDelegate = nil;
    self.eegeoMapView = nil;
}

- (void)eegeoMapReady:(id<EGMapApi>)api
{
    self.eegeoMapApi = api;
}

@end


