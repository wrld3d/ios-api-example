#import "SampleInfo.h"

@implementation SampleInfo


+ (instancetype)infoForSample:(Class)sampleClass;
{
    NSString* className = NSStringFromClass(sampleClass);
    NSString* titleKey = [NSString stringWithFormat:@"SampleTitle_%@", className];
    NSString* descKey = [NSString stringWithFormat:@"SampleDescription_%@", className];
    
    
    return [[self alloc] initWithSampleClass:className
                                       title:NSLocalizedString(titleKey, nil)
                                    subtitle:NSLocalizedString(descKey, nil)];
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
