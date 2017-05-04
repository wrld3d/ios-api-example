#pragma once
#import <Foundation/Foundation.h>

@interface SampleInfo : NSObject

@property (nonatomic) NSString* className;
@property (nonatomic) NSString* title;
@property (nonatomic) NSString* subtitle;

+ (instancetype)infoForSample:(NSString*)className
                        title:(NSString*)title
                     subtitle:(NSString*)subtitle;

@end

