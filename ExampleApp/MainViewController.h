// Copyright eeGeo Ltd (2012-2014), All Rights Reserved

#pragma once

#import <UIKit/UIKit.h>
#import "FPPopoverController.h"

@interface MainViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, FPPopoverControllerDelegate>

- (IBAction)changeMap:(UIBarButtonItem*)sender;

- (IBAction)optionSelected:(UISegmentedControl*)sender;

@property (strong, nonatomic) IBOutlet UINavigationItem* titleBar;

@property (strong, nonatomic) NSArray* mapNames;

@end
