//
//  SideView.m
//  SquareWar
//
//  Created by Mariano Abdala on 8/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SideView.h"
#import "BoardView.h"
#import "SquareView.h"

@interface SideView (PrivateAPI)
- (void)initFrame;
@end

@implementation SideView
@synthesize vertex1;
@synthesize vertex2;
@synthesize square1;
@synthesize square2;
@synthesize marked;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
    }
    return self;
}

- (id)initWithVertices:(VertexView *)newVertex1 vertex2:(VertexView *)newVertex2 {
	if (self = [super init]) {
		self.vertex1 = newVertex1;
		self.vertex2 = newVertex2;

		[self.vertex1 addSide:self];
		[self.vertex2 addSide:self];
		
		[self initFrame];
	}
	
	return self;
}

- (void)addSquare:(SquareView *)square {
	if(self.square1 == square ||
	   self.square2 == square) {
		return;
	}
	
	if(self.square1 == nil) {
		self.square1 = square;
	} else if (self.square2 == nil) {
		self.square2 = square;
	}
}

- (KeepPlaying)markWithTurn:(Turn)turn andLatest:(SideView *)latest {
	
	if(self.marked == YES) {
		return KeepPlayingYes;
	}
	
	self.marked = YES;
	
	self.alpha = 0;

	self.backgroundColor = [UIColor lightGrayColor];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.5f];
	[UIView setAnimationCurve:UIViewAnimationCurveLinear];
	
	self.alpha = 1;
	latest.backgroundColor = [UIColor blackColor];
	
	[UIView commitAnimations];
	
	KeepPlaying keepPlayingSquare1 = [square1 checkCompletedWithTurn:turn];
	KeepPlaying keepPlayingSquare2 = [square2 checkCompletedWithTurn:turn];
	
	if(keepPlayingSquare1 == KeepPlayingYes ||
	   keepPlayingSquare2 == KeepPlayingYes) {
		return KeepPlayingYes;
	} else {
		return KeepPlayingNo;
	}
}

- (void)reinit {
	self.marked = NO;
	self.backgroundColor = [UIColor clearColor];
}

- (void)remark {

    if (self.marked == YES) {
        
        self.alpha = 1;
        self.backgroundColor = [UIColor blackColor];
    }
}

- (void)initFrame {
	CGFloat x1 = self.vertex1.frame.origin.x;
	CGFloat x2 = self.vertex2.frame.origin.x;
	CGFloat y1 = self.vertex1.frame.origin.y;
	CGFloat y2 = self.vertex2.frame.origin.y;
	
	CGFloat x = x1 > x2 ? x2 : x1;
	CGFloat y = y1 > y2 ? y2 : y1;
	CGFloat width = x1 == x2 ? kDotsSize :
	x1 > x2 ? x1 - x2 : x2 - x1;
	CGFloat height = y1 == y2 ? kDotsSize :
	y1 > y2 ? y1 - y2 : y2 - y1;
	
	self.frame = CGRectMake(x1 != x2 ? x + kDotsSize : x,
							y1 != y2 ? y + kDotsSize : y,
							x1 != x2 ? width - kDotsSize : width,
							y1 != y2 ? height - kDotsSize : height);
	
	self.backgroundColor = [UIColor clearColor];
}

- (void)drawRect:(CGRect)rect {
}

- (void)dealloc {
	[vertex1 release];
	[vertex2 release];
	[square1 release];
	
	if(square2 != nil) {
		[square2 release];
	}
	
    [super dealloc];
}

+ (SideView *)getSideFromArray:(NSArray *)sides
				   withVertex1:(VertexView *)vertex1
					andVertex2:(VertexView *)vertex2 {
	for(SideView *side in sides) {
		if((side.vertex1 == vertex1 &&
			side.vertex2 == vertex2) ||
		   (side.vertex1 == vertex2 &&
			side.vertex2	== vertex1)) {
			return side;
		}
	}
	
	return nil;
}

@end
