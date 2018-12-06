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
        [SampleInfo infoForSample:[ViewController class]],
        [SampleInfo infoForSample:[MoveCamera class]],
        [SampleInfo infoForSample:[AnimateCamera class]],
        [SampleInfo infoForSample:[MoveCameraToIndoor class]],
        [SampleInfo infoForSample:[AnimateCameraToIndoor class]],
        [SampleInfo infoForSample:[FrameCamera class]],
        [SampleInfo infoForSample:[QueryCamera class]],
        [SampleInfo infoForSample:[MapTappedNotification class]],
        [SampleInfo infoForSample:[ExitIndoorMap class]],
        [SampleInfo infoForSample:[IndoorMapDisplayName class]],
        [SampleInfo infoForSample:[AddCustomIndoorControl class]],
        [SampleInfo infoForSample:[AddIndoorControl class]],
        [SampleInfo infoForSample:[AddMarker class]],
        [SampleInfo infoForSample:[MarkerCustomIcon class]],
        [SampleInfo infoForSample:[MarkerWithElevation class]],
        [SampleInfo infoForSample:[MarkerWithAbsoluteAltitude class]],
        [SampleInfo infoForSample:[AddIndoorMarker class]],
        [SampleInfo infoForSample:[MarkerChangeText class]],
        [SampleInfo infoForSample:[MarkerChangeLocation class]],
        [SampleInfo infoForSample:[MarkerTappedNotification class]],
        [SampleInfo infoForSample:[MarkerChangeDrawOrder class]],
        [SampleInfo infoForSample:[PositionViewOnMap class]],
        [SampleInfo infoForSample:[PositionCodeCreatedViewOnMap class]],
        [SampleInfo infoForSample:[AddPolygon class]],
        [SampleInfo infoForSample:[AddPolygonIndoors class]],
        [SampleInfo infoForSample:[PolygonWithInteriorPolygons class]],
        [SampleInfo infoForSample:[PolygonWithElevation class]],
        [SampleInfo infoForSample:[AddPolyline class]],
        [SampleInfo infoForSample:[AddPolylineIndoors class]],
        [SampleInfo infoForSample:[AddPropIndoors class]],
        [SampleInfo infoForSample:[BlueSphereChangeLocation class]],
        [SampleInfo infoForSample:[BlueSphereChangeHeading class]],
        [SampleInfo infoForSample:[BlueSphereChangeElevation class]],
        [SampleInfo infoForSample:[BlueSphereIndoors class]],
        [SampleInfo infoForSample:[InitialStreamingCompleteNotification class]],
        [SampleInfo infoForSample:[SearchExample class]],
        [SampleInfo infoForSample:[CancelSearch class]],
        [SampleInfo infoForSample:[LoadMapsceneExample class]],
        [SampleInfo infoForSample:[FindOutdoorRoute class]],
        [SampleInfo infoForSample:[FindIndoorRoute class]],
        [SampleInfo infoForSample:[FindMultipartRoute class]],
        [SampleInfo infoForSample:[CancelRoutingQuery class]],
        [SampleInfo infoForSample:[RouteView class]],
        [SampleInfo infoForSample:[RouteViewStyle class]],
        [SampleInfo infoForSample:[RouteViewMarkers class]],
        [SampleInfo infoForSample:[AddBuildingHighlight class]],
        [SampleInfo infoForSample:[RemoveBuildingHighlight class]],
        [SampleInfo infoForSample:[QueryBuildingInformation class]],
        [SampleInfo infoForSample:[PickingBuildings class]],
        [SampleInfo infoForSample:[PlaceObjectsOnBuildings class]],
        [SampleInfo infoForSample:[HighlightIndoorMapEntities class]],
        [SampleInfo infoForSample:[QueryIndoorMapEntities class]],
        [SampleInfo infoForSample:[PrecacheMapData class]],
        [SampleInfo infoForSample:[CancelPrecacheMapData class]]
    ];
    
    self.title = @"WRLD iOS API Samples";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Samples" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.00 green:113.0/255 blue:188.0/255 alpha:1.0];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView setUserInteractionEnabled:YES];
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
    cell.clipsToBounds = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:SegueTableToSample sender:cell];
    [tableView setUserInteractionEnabled:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SampleInfo* sampleInfo = [self.samples objectAtIndex:indexPath.row];
    
    CGFloat margin = tableView.layoutMargins.left + tableView.layoutMargins.right;
    
    CGRect rect = [sampleInfo.subtitle boundingRectWithSize:CGSizeMake(CGRectGetWidth(tableView.bounds) - margin - 16, CGFLOAT_MAX)
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
