#import "ViewController.h"
@import Wrld;
@import WrldWidgets;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // force linkage with Wrld.framework and WrldWidgets.framework
    [WRLDMapView class];
    [WRLDIndoorControlView class];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL) shouldAutorotate
{
    return false;
}


@end
