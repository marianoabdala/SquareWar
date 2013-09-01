//
//  SquareWarAppDelegate.m
//  SquareWar
//
//  Created by Mariano Abdala on 8/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SquareWarAppDelegate.h"
#import "SquareWarViewController.h"

@implementation SquareWarAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
