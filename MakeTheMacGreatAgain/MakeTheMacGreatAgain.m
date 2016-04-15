//
//  MakeTheMacGreatAgain.m
//  MakeTheMacGreatAgain
//
//  Created by Craig Edwards on 15/04/2016.
//  Copyright © 2016 BlackDog Foundry Pty Ltd. All rights reserved.
//

#import "MakeTheMacGreatAgain.h"
#import "JRSwizzle.h"

@interface IDETemplateInstantiationContext
-(NSArray *)arrayBySortingSections:(NSArray *)sections;
@end
@interface IDETemplateSection: NSObject
-(NSString *)navigableItem_name;
@end

@implementation NSObject (SwizzledMethods)

/**
 * All this method does is take the sections that Xcode has sorted, and 
 * then re-order them so that the OS X section is first.
 */
-(NSArray *)mtmga_arrayBySortingSections:(NSArray *)sections {
	// ask Xcode to sort using the original swizzled method
	NSArray *xCodeSortedSections = [self mtmga_arrayBySortingSections:sections];
	
	// now pull out the "OS X" section and it to our new list
	NSMutableArray *macsAreGreatSections = [NSMutableArray array];
	for (IDETemplateSection *section in xCodeSortedSections) {
		if ([[section navigableItem_name] isEqualToString:@"MacOS"]) {
			[macsAreGreatSections addObject:section];
		}
	}
	// now add the rest of them...
	for (IDETemplateSection *section in xCodeSortedSections) {
		if (![[section navigableItem_name] isEqualToString:@"MacOS"]) {
			[macsAreGreatSections addObject:section];
		}
	}
	return macsAreGreatSections;
}

/**
 * We all know that for the Mac to be truely great again we must return to
 * what our forfathers used. MacOS.
 */
-(NSString *)mtmga_navigableItem_name {
    NSString *name = [self mtmga_navigableItem_name];

    if ([name isEqualToString:@"OS X"]) {
        name = @"MacOS";
    }

    return name;
}

@end

@implementation MakeTheMacGreatAgain

+(instancetype)sharedPlugin {
	return sharedPlugin;
}

-(id)initWithBundle:(NSBundle *)plugin {
	if (self = [super init]) {
		NSError *error = nil;
		Class clazz = NSClassFromString(@"IDETemplateInstantiationContext");
		if (![clazz jr_swizzleMethod:@selector(arrayBySortingSections:) withMethod:@selector(mtmga_arrayBySortingSections:) error:&error]) {
			NSLog(@"Unable to swizzle sort method: %@", error);
		}
        Class clazzz = NSClassFromString(@"IDETemplateSection");
        if (![clazzz jr_swizzleMethod:@selector(navigableItem_name) withMethod:@selector(mtmga_navigableItem_name) error:&error]) {
            NSLog(@"Unable to swizzle name method: %@", error);
        }
	}
	return self;
}

@end
