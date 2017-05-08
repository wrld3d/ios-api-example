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
        [SampleInfo infoForSample:[BasicMap class]],
        [SampleInfo infoForSample:[StartingLocation class]],
        [SampleInfo infoForSample:[MoveCamera class]],
        [SampleInfo infoForSample:[AnimateCamera class]],
        [SampleInfo infoForSample:[FrameCamera class]],
        [SampleInfo infoForSample:[MapSceneLoadedNotification class]],
        [SampleInfo infoForSample:[AddMarker class]],
        [SampleInfo infoForSample:[MarkerChangeDrawOrder class]]
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
    cell.detailTextLabel.numberOfLines = 0;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:SegueTableToSample sender:cell];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SampleInfo* sampleInfo = [self.samples objectAtIndex:indexPath.row];
    
    CGFloat margin = tableView.layoutMargins.left + tableView.layoutMargins.right;
    
    CGRect rect = [sampleInfo.subtitle boundingRectWithSize:CGSizeMake(CGRectGetWidth(tableView.bounds) - margin, CGFLOAT_MAX)
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{}
                                                    context:nil];
    return rect.size.height + 30;
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
