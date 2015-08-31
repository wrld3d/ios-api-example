// Copyright eeGeo Ltd (2012-2014), All Rights Reserved

#import "MainViewController.h"
#import "FPPopoverController.h"
#import "MapContainerDelegate.h"

@implementation MainViewController
{
    UIViewController* m_pMapContainer;
    UIViewController<MapContainerDelegate>* m_pCurrentMapViewController;
}

- (void)dealloc
{
    [self.titleBar release];
    [self.mapNames release];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    m_pCurrentMapViewController = nil;

    self.mapNames = @[@"eeGeo 3D Maps", @"Apple Maps", @"Google Maps"];
    
    [self loadMapWithName: self.mapNames[0]];
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
    
    //self.titleBar.title = mapName;
    [self.navigationItem setTitle:mapName];
}

- (IBAction)optionSelected:(UISegmentedControl*)sender
{
    switch(sender.selectedSegmentIndex)
    {
        case 0: [m_pCurrentMapViewController goHome]; break;
        case 1: [m_pCurrentMapViewController fitToDefaultBounds];break;
    }
}

- (IBAction)changeMap:(UIBarButtonItem*)sender
{
    UIView* btnView = [sender valueForKey:@"view"];
    UITableViewController *controller = [[[UITableViewController alloc] init] autorelease];
    controller.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    controller.tableView.delegate = self;
    controller.tableView.dataSource = self;
    FPPopoverController* popover = [[FPPopoverController alloc] initWithViewController:controller];
    popover.delegate = self;
    popover.border = NO;
    popover.tint = FPPopoverWhiteTint;
    popover.arrowDirection = UIMenuControllerArrowDown;
    popover.contentSize = CGSizeMake(200,200);
    [popover presentPopoverFromView:btnView];
}

- (UIViewController<MapContainerDelegate>*)viewControllerWithName:(NSString*)name
{
    return [self.storyboard instantiateViewControllerWithIdentifier:name];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mapNames count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_id"];

    if (cell == nil)
    {
       cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyIdentifier"] autorelease];
    }
    
    cell.textLabel.text = self.mapNames[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self loadMapWithName: self.mapNames[indexPath.row]];
}

- (void)popoverControllerDidDismissPopover:(FPPopoverController *)popoverController
{
    [popoverController release];
}

@end
