// Copyright eeGeo Ltd (2012-2014), All Rights Reserved

#pragma once

#import <UIKit/UIKit.h>

#import "EGAnnotationView.h"

@interface EegeoCustomAnnotationView : EGAnnotationView

@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) IBOutlet UILabel* title;

@end
