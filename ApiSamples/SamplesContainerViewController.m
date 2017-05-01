#import "SamplesContainerViewController.h"

@interface SamplesContainerViewController ()

@end

@implementation SamplesContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.sampleToLoad;
    
    if (NSClassFromString(self.sampleToLoad)) {
        UIViewController *childViewController = [[NSClassFromString(self.sampleToLoad) alloc] init];
        [self addChildViewController:childViewController];
        [self.view addSubview:childViewController.view];
        [childViewController didMoveToParentViewController:self];
    }
}

@end
