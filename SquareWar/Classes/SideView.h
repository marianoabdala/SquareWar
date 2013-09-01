//
//  SideView.h
//  SquareWar
//
//  Created by Mariano Abdala on 8/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VertexView.h"
#import "Enums.h"

@class SquareView;

@interface SideView : UIView {
	VertexView *vertex1;
	VertexView *vertex2;
	SquareView *square1;
	SquareView *square2;
	BOOL marked;
}

@property (nonatomic, retain) VertexView *vertex1;
@property (nonatomic, retain) VertexView *vertex2;
@property (nonatomic, retain) SquareView *square1;
@property (nonatomic, retain) SquareView *square2;
@property (nonatomic, assign) BOOL marked;

- (id)initWithVertices:(VertexView *)vertex1 vertex2:(VertexView *)vertex2;
- (void)addSquare:(SquareView *)square;
- (KeepPlaying)markWithTurn:(Turn)turn andLatest:(SideView *)latest;
- (void)reinit;
+ (SideView *)getSideFromArray:(NSArray *)sides
				   withVertex1:(VertexView *)vertex1
					andVertex2:(VertexView *)vertex2;

@end
