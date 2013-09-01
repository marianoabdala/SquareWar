//
//  VertexView.m
//  SquareWar
//
//  Created by Mariano Abdala on 8/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "VertexView.h"
#import "SideView.h"

@implementation VertexView
@synthesize coordinates;
@synthesize side1;
@synthesize side2;
@synthesize side3;
@synthesize side4;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)addSide:(SideView *)side {
	if(self.side1 == side ||
	   self.side2 == side ||
	   self.side3 == side ||
	   self.side4 == side) {
		return;
	}

	if(self.side1 == nil) {
		self.side1 = side;
	} else if (self.side2 == nil) {
		self.side2 = side;
	} else if (self.side3 == nil) {
		self.side3 = side;
	} else if (self.side4 == nil) {
		self.side4 = side;
	}
}

- (void)drawRect:(CGRect)rect {
	/*
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	CGContextSetStrokeColorWithColor(context, kDotsColor);
	CGContextSetFillColorWithColor(context, kDotsColor);
	
	CGContextAddRect(context, self.frame);	
	
	CGContextDrawPath(context, kCGPathFillStroke);
	 */
}

- (void)dealloc {
	if(side1 != nil) [side1 release];
	if(side2 != nil) [side2 release];
	if(side3 != nil) [side3 release];
	if(side4 != nil) [side4 release];
    [super dealloc];
}

+ (VertexView *)getVertexFromArray:(NSArray *)vertices
			 withCoordinates:(Coordinates)coordinates {
	for(VertexView *vertex in vertices) {
		if(vertex.coordinates.i == coordinates.i &&
		   vertex.coordinates.j == coordinates.j) {
			return vertex;
		}
	}
	
	return nil;
}


@end
