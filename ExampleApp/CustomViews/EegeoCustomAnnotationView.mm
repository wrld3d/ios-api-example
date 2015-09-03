// Copyright (c) 2015 eeGeo. All rights reserved.

#import <QuartzCore/QuartzCore.h>
#import "EegeoCustomAnnotationView.h"

@implementation EegeoCustomAnnotationView

- (void)initWithAnnotation:(NSObject<EGAnnotation>*)annotation
{
    [super initWithAnnotation:annotation];
    
    [self addObserver:self
           forKeyPath:@"selected"
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
}

- (void) dealloc
{
    [self removeObserver:self forKeyPath:@"selected"];
    
    [self.title release];
    [self.imageView release];
    
    [super dealloc];
}

- (void)setAnnotationViewLabelsFromAnnotation
{
    [self.title setText:self.annotation.title];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.bounds = CGRectMake(0,
                             0,
                             self.imageView.bounds.size.width,
                             self.imageView.bounds.size.height + self.title.bounds.size.height);
    
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [[UIScreen mainScreen] scale];
}

- (void)handleSelectedChanged
{
    if(self.selected)
    {
        self.layer.cornerRadius = 20;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 16;
        self.layer.shadowOpacity = 0.8f;
        self.layer.shadowColor = [[UIColor greenColor] CGColor];
    }
    else
    {
        self.layer.cornerRadius = 0;
        self.layer.shadowOpacity = 0;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    self.selected = selected;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if(object == self)
    {
        if ([keyPath isEqual:@"selected"])
        {
            [self handleSelectedChanged];
        }
    }
}

@end
