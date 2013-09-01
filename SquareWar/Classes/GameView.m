//
//  GameView.m
//  SquareWar
//
//  Created by Mariano Abdala on 8/21/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameView.h"

@interface GameView (PrivateAPI)
- (void)initGrid;
@end

@implementation GameView

- (void)drawRect:(CGRect)rect {
	[self initGrid];
}

- (void)initGrid {

	/*
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetStrokeColorWithColor(context, kDotsColor);
	CGContextSetFillColorWithColor(context, kDotsColor);
	
	for(int x = kDotsSpacing; x <= self.frame.size.width - kDotsSpacing; x += kDotsSpacing) {
		for(int y = kDotsSpacing; y <= self.frame.size.height - kDotsSpacing; y += kDotsSpacing) {
			CGContextAddEllipseInRect(context, CGRectMake(x - kDotsSize / 2,
														  y - kDotsSize / 2,
														  kDotsSize,
														  kDotsSize));	
		}
	}

	CGContextDrawPath(context, kCGPathFillStroke);
	 */
}

- (void)dealloc {
    [super dealloc];
}


@end
