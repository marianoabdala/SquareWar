//
//  SquareWarAppDelegate.m
//  SquareWar
//
//  Created by Mariano Abdala on 8/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SquareWarAppDelegate.h"
#import "SquareWarViewController.h"

@interface SquareWarAppDelegate ()

@property (retain, nonatomic) SquareWarViewController *viewController;

@end

@implementation SquareWarAppDelegate

@synthesize window;
@synthesize viewController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    BOOL is4InchDisplay =
    [[UIScreen mainScreen] bounds].size.height == 568.0f;

    if (is4InchDisplay == NO) {
        
        self.viewController =
        [[SquareWarViewController alloc] initWithNibName:@"SquareWarViewController"
                                                  bundle:nil];
        
    } else {
        
        self.viewController =
        [[SquareWarViewController alloc] initWithNibName:@"SquareWarViewController40"
                                                  bundle:nil];
    }
    
    window.rootViewController = self.viewController;

    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
