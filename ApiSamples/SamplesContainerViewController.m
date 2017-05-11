#import "SamplesContainerViewController.h"

@interface SamplesContainerViewController ()

@property (nonatomic) UIViewController *childViewController;

@end

@implementation SamplesContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.sampleToLoad.title;
    
    if (NSClassFromString(self.sampleToLoad.className)) {
        _childViewController = [[NSClassFromString(self.sampleToLoad.className) alloc] init];
        [self addChildViewController:_childViewController];
        [self.view addSubview:_childViewController.view];
        [_childViewController didMoveToParentViewController:self];
    }
}

- (BOOL) shouldAutorotate
{
    return [_childViewController shouldAutorotate];
}

@end
