//
//  SquareWarAppDelegate.h
//  SquareWar
//
//  Created by Mariano Abdala on 8/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SquareWarViewController;

@interface SquareWarAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    SquareWarViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet SquareWarViewController *viewController;

@end

