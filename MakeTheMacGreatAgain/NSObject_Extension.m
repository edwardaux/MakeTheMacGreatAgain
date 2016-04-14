//
//  NSObject_Extension.m
//  MakeTheMacGreatAgain
//
//  Created by Craig Edwards on 15/04/2016.
//  Copyright © 2016 BlackDog Foundry Pty Ltd. All rights reserved.
//


#import "NSObject_Extension.h"
#import "MakeTheMacGreatAgain.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[MakeTheMacGreatAgain alloc] initWithBundle:plugin];
        });
    }
}
@end
