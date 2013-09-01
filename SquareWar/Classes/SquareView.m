//
//  SquareView.m
//  SquareWar
//
//  Created by Mariano Abdala on 8/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SquareView.h"
#import "SideView.h"
#import "BoardView.h"

@interface SquareView (PrivateAPI)
+ (UIColor *)uiColorForColor:(Color)color;
@end

@implementation SquareView
@synthesize side1;
@synthesize side2;
@synthesize side3;
@synthesize side4;
@synthesize completed;
@synthesize completedTurn;
@synthesize delegate;

- (KeepPlaying)checkCompletedWithTurn:(Turn)turn {
	if(side1.marked == YES &&
	   side2.marked == YES &&
	   side3.marked == YES &&
	   side4.marked == YES) {
		self.completed = YES;
		self.completedTurn = turn;
		
		self.alpha = 0;
		
		if(self.completedTurn == TurnMachine) {
			self.backgroundColor = [SquareView uiColorForColor:delegate.machineColor];
		} else { //TurnUser
			self.backgroundColor = [SquareView uiColorForColor:delegate.userColor];
		}
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5f];
		[UIView setAnimationCurve:UIViewAnimationCurveLinear];
		
		self.alpha = 1;
		
		[UIView commitAnimations];
		
		return KeepPlayingYes;
	}
	
	return KeepPlayingNo;
}

- (void)repaint {
	if(self.completedTurn == TurnMachine) {
		self.backgroundColor = [SquareView uiColorForColor:delegate.machineColor];
	} else { //TurnUser
		self.backgroundColor = [SquareView uiColorForColor:delegate.userColor];
	}
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (id)initWithSides:(SideView *)newSide1
			  side2:(SideView *)newSide2
			  side3:(SideView *)newSide3
			  side4:(SideView *)newSide4 {
	if(self = [super init]) {
		self.side1 = newSide1;
		self.side2 = newSide2;
		self.side3 = newSide3;
		self.side4 = newSide4;
		
		CGFloat x = self.side1.frame.origin.x;
		CGFloat y = self.side1.frame.origin.y  + kDotsSize;
		CGFloat width = kDotsSpacing - kDotsSize;
		CGFloat height = kDotsSpacing - kDotsSize; 
		
		self.frame = CGRectMake(x, y, width, height);
		self.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (int)getSideCount {
	int count = 0;
	
	if(self.side1 != nil) {
		if(self.side1.marked == YES) {
			count++;
		}
	}
	
	if(self.side2 != nil) {
		if(self.side2.marked == YES) {
			count++;
		}
	}
	
	if(self.side3 != nil) {
		if(self.side3.marked == YES) {
			count++;
		}
	}
	
	if(self.side4 != nil) {
		if(self.side4.marked == YES) {
			count++;
		}
	}
	
	return count;
}

- (void)reinit {
	self.completed = NO;
	self.completedTurn = -1;
	self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}


- (void)dealloc {
	[side1 dealloc];
	[side2 dealloc];
	[side3 dealloc];
	[side4 dealloc];
    [super dealloc];
}

+ (BOOL)checkAllCompletedInArray:(NSArray *)squares {
	for(SquareView *square in squares) {
		if(square.completed == NO) {
			return NO;
		}
	}
	
	return YES;
}

+ (int)countCompletedInArray:(NSArray *)squares byTurn:(Turn)turn {
	int count = 0;
	
	for(SquareView *square in squares) {
		if(square.completed == YES &&
		   square.completedTurn == turn) {
			count++;
		}
	}
	
	return count;
}

+ (UIColor *)uiColorForColor:(Color)color {
	UIColor *uiColor = nil;
	
	switch (color) {
		case ColorBlue:
			uiColor = [UIColor blueColor];
			break;
			
		case ColorCyan:
			uiColor = [UIColor cyanColor];
			break;
			
		case ColorGreen:
			uiColor = [UIColor greenColor];
			break;
			
		case ColorMagenta:
			uiColor = [UIColor magentaColor];
			break;
			
		case ColorOrange:
			uiColor = [UIColor orangeColor];
			break;
			
		case ColorPurple:
			uiColor = [UIColor purpleColor];
			break;
			
		case ColorRed:
			uiColor = [UIColor redColor];
			break;
			
		case ColorYellow:
			uiColor = [UIColor yellowColor];
			break;
	}
	
	
	return uiColor;
}

@end
