#pragma once
#import <Foundation/Foundation.h>

@interface SamplesMessage : NSObject

+ (void)showWithMessage:(NSString *)message;

+ (void)showWithMessage:(NSString *)message
            andDuration:(NSNumber*)duration;

@end
