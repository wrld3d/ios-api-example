#import "MainTableViewController.h"
#import "SamplesContainerViewController.h"
#import "SampleInfo.h"
#import "Samples/SampleClasses.h"

NSString *const SegueTableToSample = @"TableToSampleSegue";

@interface MainTableViewController ()

@end

@implementation MainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.samples = @[
        [SampleInfo infoForSample:NSStringFromClass ([BasicMap class])
                            title:@"Embed a 3D map"
                         subtitle:@"How to embed a 3D map view for iOS"],
        
        [SampleInfo infoForSample:NSStringFromClass ([StartingLocation class])
                            title:@"Set start location"
                         subtitle:@"Setting the start location of the map"],
        
        [SampleInfo infoForSample:NSStringFromClass ([MoveCamera class])
                            title:@"Move the camera"
                         subtitle:@"Simple camera movement"],
        
        [SampleInfo infoForSample:NSStringFromClass ([AnimateCamera class])
                            title:@"Animate the camera"
                         subtitle:@"Move the camera with animation"],
        
        [SampleInfo infoForSample:NSStringFromClass ([FrameCamera class])
                            title:@"Frame an area"
                         subtitle:@"Move the map camera to frame an area"],
        
        [SampleInfo infoForSample:NSStringFromClass ([MapSceneLoadedNotification class])
                            title:@"Map scene loaded notification"
                         subtitle:@"Receive notification that the loading of map resources for the initial scene has completed"]
        ];
    
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.samples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    
    SampleInfo* sampleInfo = [self.samples objectAtIndex:indexPath.row];
    cell.textLabel.text = sampleInfo.title;
    cell.detailTextLabel.text = sampleInfo.subtitle;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:SegueTableToSample sender:cell];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:SegueTableToSample]) {
        if ([sender isKindOfClass:[UITableViewCell class]]) {
            UITableViewCell *senderCell = sender;
            NSIndexPath* indexPath = [self.tableView indexPathForCell:senderCell];
            SamplesContainerViewController *destinationVC = [segue destinationViewController];
            destinationVC.sampleToLoad = [self.samples objectAtIndex:indexPath.row];
        }
    }
}


@end
