//
//  MakeTheMacGreatAgain.h
//  MakeTheMacGreatAgain
//
//  Created by Craig Edwards on 15/04/2016.
//  Copyright © 2016 BlackDog Foundry Pty Ltd. All rights reserved.
//

#import <AppKit/AppKit.h>

@class MakeTheMacGreatAgain;

static MakeTheMacGreatAgain *sharedPlugin;

@interface MakeTheMacGreatAgain : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end