// Copyright (c) 2015 eeGeo. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "AppleCustomAnnotationView.h"
#import <MapKit/MKAnnotation.h>

@implementation AppleCustomAnnotationView

- (instancetype)initWithAnnotation:(id <MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;
{
    id instance = [super initWithAnnotation: annotation reuseIdentifier:reuseIdentifier];

    [self.title setText: [self.annotation title]];
    
    [self addObserver:self
           forKeyPath:@"selected"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
    
    return instance;
}

- (void) dealloc
{
    [self removeObserver:self forKeyPath:@"selected"];
    
    [self.imageView release];
    
    [super dealloc];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (void)handleSelectedChanged
{
    if(self.selected)
    {
        self.layer.cornerRadius = 8;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 5;
        self.layer.shadowOpacity = 0.5;
        self.layer.shadowColor = [[UIColor blueColor] CGColor];
    }
    else
    {
        self.layer.cornerRadius = 0;
        self.layer.shadowOpacity = 0;
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if(object == self)
    {
        if ([keyPath isEqual:@"selected"])
        {
            [self handleSelectedChanged];
        }
    }
}

@end
