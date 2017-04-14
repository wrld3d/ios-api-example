// Copyright eeGeo Ltd (2012-2014), All Rights Reserved

#import "MainViewController.h"
#import "MapContainerDelegate.h"

@implementation MainViewController
{
    UIViewController* m_pMapContainer;
    UIViewController<MapContainerDelegate>* m_pCurrentMapViewController;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    m_pCurrentMapViewController = nil;
    
    [self loadMapWithName: @"eeGeo 3D Maps"];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString: @"MapContainerEmbedSegue"])
    {
        m_pMapContainer = [segue destinationViewController];
    }
}

- (void)loadMapWithName:(NSString*)mapName
{
    //https://developer.apple.com/library/ios/featuredarticles/ViewControllerPGforiPhoneOS/CreatingCustomContainerViewControllers/CreatingCustomContainerViewControllers.html
    
    if(m_pCurrentMapViewController != nil)
    {
        [m_pCurrentMapViewController willMoveToParentViewController:nil];
        [m_pCurrentMapViewController.view removeFromSuperview];
        [m_pCurrentMapViewController removeFromParentViewController];
    }
    
    m_pCurrentMapViewController = [self viewControllerWithName:mapName];
    
    [m_pMapContainer addChildViewController:m_pCurrentMapViewController];
    m_pCurrentMapViewController.view.frame = m_pMapContainer.view.frame;
    [m_pMapContainer.view addSubview:m_pCurrentMapViewController.view];
    [m_pCurrentMapViewController didMoveToParentViewController:m_pMapContainer];
}

- (UIViewController<MapContainerDelegate>*)viewControllerWithName:(NSString*)name
{
    return [self.storyboard instantiateViewControllerWithIdentifier:name];
}

@end
