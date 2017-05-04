#import "SamplesContainerViewController.h"

@interface SamplesContainerViewController ()

@end

@implementation SamplesContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.sampleToLoad.title;
    
    if (NSClassFromString(self.sampleToLoad.className)) {
        UIViewController *childViewController = [[NSClassFromString(self.sampleToLoad.className) alloc] init];
        [self addChildViewController:childViewController];
        [self.view addSubview:childViewController.view];
        [childViewController didMoveToParentViewController:self];
    }
}

@end
