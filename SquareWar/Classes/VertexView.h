//
//  VertexView.h
//  SquareWar
//
//  Created by Mariano Abdala on 8/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kDotsColor		[UIColor blackColor]
@class SideView;

typedef struct {
	int i;
	int j;
} Coordinates;

static inline Coordinates CoordinatesMake(int i, int j)
{
    Coordinates ret;
	ret.i = i;
	ret.j = j;
    return ret;
}

@interface VertexView : UIView {
	Coordinates coordinates;
	SideView *side1;
	SideView *side2;
	SideView *side3;
	SideView *side4;
}

@property (nonatomic, assign) Coordinates coordinates;
@property (nonatomic, retain) SideView *side1;
@property (nonatomic, retain) SideView *side2;
@property (nonatomic, retain) SideView *side3;
@property (nonatomic, retain) SideView *side4;

- (void)addSide:(SideView *)side;
+ (VertexView *)getVertexFromArray:(NSArray *)vertices
			 withCoordinates:(Coordinates)coordinates;

@end
