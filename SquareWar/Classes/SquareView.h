//
//  SquareView.h
//  SquareWar
//
//  Created by Mariano Abdala on 8/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SideView.h"
#import "Enums.h"

@protocol SquareViewDelegate;

@interface SquareView : UIView {
	SideView *side1;
	SideView *side2;
	SideView *side3;
	SideView *side4;
	BOOL completed;
	Turn completedTurn;
	
	id<SquareViewDelegate> delegate;
}

@property (nonatomic, retain) SideView *side1;
@property (nonatomic, retain) SideView *side2;
@property (nonatomic, retain) SideView *side3;
@property (nonatomic, retain) SideView *side4;
@property (nonatomic, assign) BOOL completed;
@property (nonatomic, assign) Turn completedTurn;
@property (nonatomic, assign) id<SquareViewDelegate> delegate;

- (id)initWithSides:(SideView *)side1
			  side2:(SideView *)side2
			  side3:(SideView *)side3
			  side4:(SideView *)side4;
- (KeepPlaying)checkCompletedWithTurn:(Turn)turn;
- (int)getSideCount;
- (void)reinit;
- (void)repaint;
+ (BOOL)checkAllCompletedInArray:(NSArray *)squares;
+ (int)countCompletedInArray:(NSArray *)squares byTurn:(Turn)turn;

@end

@protocol SquareViewDelegate<NSObject>
@optional
- (Color)userColor;
- (Color)machineColor;
@end
