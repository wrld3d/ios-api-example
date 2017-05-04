#import "SampleInfo.h"

@implementation SampleInfo

+ (instancetype)infoForSample:(NSString*)className
                        title:(NSString*)title
                     subtitle:(NSString*)subtitle
{
    return [[self alloc] initWithSampleClass:className
                                       title:title
                                    subtitle:subtitle];
}

- (instancetype)initWithSampleClass:(NSString*)className
                              title:(NSString*)title
                           subtitle:(NSString*)subtitle
{
    if (self = [super init])
    {
        self.className = className;
        self.title = title;
        self.subtitle = subtitle;
    }
    return self;
}

@end
