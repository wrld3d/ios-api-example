// Copyright eeGeo Ltd (2012-2014), All Rights Reserved

#pragma once

#import <UIKit/UIKit.h>

#import <MapKit/MKAnnotationView.h>

@interface AppleCustomAnnotationView : MKAnnotationView

@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) IBOutlet UILabel* title;

@end
