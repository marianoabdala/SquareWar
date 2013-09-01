//
//  BoardView.m
//  SquareWar
//
//  Created by Mariano Abdala on 8/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "BoardView.h"
#import "VertexView.h"
#import "SideView.h"
#import "NSMutableArray-Shuffling.h"

CGFloat distanceBetweenPoints (CGPoint first, CGPoint second) {
	CGFloat deltaX = second.x - first.x;
	CGFloat deltaY = second.y - first.y;
	return sqrt(deltaX*deltaX + deltaY*deltaY );
};

@interface BoardView (PrivateAPI)
- (void)initVertices;
- (void)initSides;
- (void)initSquares;
- (void)giveTurn:(Turn)nextTurn;
- (void)playMachine;
- (void)gameOver;
- (int)countSquaresToResignByPlayingSide:(SideView *)side;
- (int)countSquaresToResignByPlayingSide:(SideView *)side inSquare:(SquareView *)square;
- (SideView *)getOtherUnmarkedSideForSide:(SideView *)side inSquare:(SquareView *)square;
@end

@implementation BoardView
@synthesize squares;
@synthesize sides;
@synthesize vertices;
@synthesize lastSideSelected;
@synthesize delegate;

- (void)initVertices {
	CGFloat width = self.frame.size.width;
	CGFloat height = self.frame.size.height;
	
	NSMutableArray *mutVertices = [[NSMutableArray alloc] init];
	
	for(int x = kDotsMarginX, i = 0; x <= width - kDotsMarginX; x += kDotsSpacing, i++) {
		for(int y = kDotsMarginY, j = 0; y <= height - kDotsMarginY; y += kDotsSpacing, j++) {
			
			CGRect vertexRect = CGRectMake(x - kDotsSize / 2,
										   y - kDotsSize / 2,
										   kDotsSize,
										   kDotsSize);
			
			VertexView *vertex = [[VertexView alloc] initWithFrame:vertexRect];
			vertex.coordinates = CoordinatesMake(i, j);
			[self addSubview:vertex];
			
			[mutVertices addObject:vertex];
			[vertex release];
		}
	}
	
	self.vertices = [[NSArray alloc] initWithArray:mutVertices];
	[mutVertices release];	
}

- (void)initSides {
	
	if(self.sides != nil) {
		[sides release];
	}
		
	self.sides = [[NSMutableArray alloc] init];
	
	for(VertexView *vertex1 in vertices) {
		for(VertexView *vertex2 in vertices) {
			if((vertex1.coordinates.i == vertex2.coordinates.i - 1 &&
			   vertex1.coordinates.j == vertex2.coordinates.j) ||
				(vertex1.coordinates.i == vertex2.coordinates.i &&
				vertex1.coordinates.j == vertex2.coordinates.j + 1)) {
				SideView *side = [[SideView alloc] initWithVertices:vertex1
															vertex2:vertex2];
				
				[self addSubview:side];
				
				[self.sides addObject:side];
				[side release];
			}
		}
	}
}

- (void)initSquares {
	
	NSMutableArray *mutSquares = [[NSMutableArray alloc] init];
	
	for(VertexView *vertex in self.vertices) {
		
		VertexView *vertexRight = [VertexView getVertexFromArray:self.vertices
									   withCoordinates:CoordinatesMake(vertex.coordinates.i + 1, vertex.coordinates.j)];
		
		if(vertexRight == nil) {
			continue;
		}
		
		VertexView *vertexBottom = [VertexView getVertexFromArray:self.vertices
											withCoordinates:CoordinatesMake(vertex.coordinates.i, vertex.coordinates.j + 1)];

		if(vertexBottom == nil) {
			continue;
		}
		
		VertexView *vertexBottomRight = [VertexView getVertexFromArray:self.vertices
											withCoordinates:CoordinatesMake(vertex.coordinates.i + 1, vertex.coordinates.j + 1)];

		if(vertexBottomRight == nil) {
			continue;
		}
		
		SideView *side1 = [SideView getSideFromArray:self.sides
										 withVertex1:vertex
										  andVertex2:vertexRight];
		
		SideView *side2 = [SideView getSideFromArray:self.sides
										 withVertex1:vertexRight
										  andVertex2:vertexBottomRight];
		
		SideView *side3 = [SideView getSideFromArray:self.sides
										 withVertex1:vertexBottomRight
										  andVertex2:vertexBottom];
		
		SideView *side4 = [SideView getSideFromArray:self.sides
										 withVertex1:vertexBottom
										  andVertex2:vertex];
		
		SquareView *square = [[SquareView alloc] initWithSides:side1
														 side2:side2
														 side3:side3
														 side4:side4];
		
		square.delegate = self;
		
		[side1 addSquare:square];
		[side2 addSquare:square];
		[side3 addSquare:square];
		[side4 addSquare:square];
		
		[self addSubview:square];
		
		[mutSquares addObject:square];
		[square release];
	}
	
	self.squares = [[NSArray alloc] initWithArray:mutSquares];
	[mutSquares release];
}

- (void)playMachine {
	
	[self.sides shuffle];

	SideView *sideToMark = nil;

	for(SideView *side in self.sides) {
		//Try to get a square done.
		if(side.marked == YES) {
			//No point on marking it twice.
			continue;
		}
		
		if([side.square1 getSideCount] == 3 ||
		   [side.square2 getSideCount] == 3) {
			sideToMark = side;
			break;
		}
	}
	
	if(self.delegate.gameDifficulty == GameDifficultyEasy) {
		//If the game difficulty is set to easy, from time to time
		//let pass a 3 sides square.
		srand(time(NULL));

		if(rand() % 100 > 70) {
			sideToMark = nil;
		}
	}
	
	if(sideToMark == nil) {
		for(SideView *side in self.sides) {
			if(side.marked == YES) {
				//No point on marking it twice.
				continue;
			}
		
			if([side.square1 getSideCount] == 2 ||
			   [side.square2 getSideCount] == 2) {
				//A third side will leave open the chance
				//for a square on the user's side.
				continue;
			}
		
			sideToMark = side;
			break;
		}
	}
	
	if(sideToMark == nil) {
		
		int lesserSquaresToResign = INT_MAX;
		
		//Same thing ignore for 2 sided squares.
		for(SideView *side in self.sides) {
			if(side.marked == YES) {
				//No point on marking it twice.
				continue;
			}

			//Machine has to give up some squares...

			if(self.delegate.gameDifficulty == GameDifficultyHard) {
				//Let's try to mark the square that will result on
				//less squares for the user.
				int squaresToResignOfSide = [self countSquaresToResignByPlayingSide:side];

				if(squaresToResignOfSide < lesserSquaresToResign) {
					sideToMark = side;
					lesserSquaresToResign = squaresToResignOfSide;
				}
			} else {
				sideToMark = side;
				break;
			}
		}
	}
	
	BOOL keepPlaying = [sideToMark markWithTurn:TurnMachine andLatest:lastSideSelected];
	lastSideSelected = sideToMark;	
	
	if(keepPlaying == KeepPlayingYes) {
		[self giveTurn:TurnMachine];
	} else {
		[self giveTurn:TurnUser];
	}
}

- (void)giveTurn:(Turn)nextTurn {
    
	if([SquareView checkAllCompletedInArray:self.squares] == YES) {
		[self gameOver];
		return;
	}
	
	if(nextTurn == TurnMachine) {
		self.userInteractionEnabled = NO;
		[NSTimer scheduledTimerWithTimeInterval:1
										 target:self
									   selector:@selector(playMachine)
									   userInfo:nil
										repeats:NO];
	} else if([self.delegate boardViewIsPlaying:self]) {
		self.userInteractionEnabled = YES;
	}
}

- (void)gameOver {
	self.userInteractionEnabled = NO;
	
	int userCount = [SquareView countCompletedInArray:self.squares byTurn:TurnUser];
	int machineCount = [SquareView countCompletedInArray:self.squares byTurn:TurnMachine];
	
	NSString *title;
	
	if(userCount == machineCount) {
		title = @"It was a tie!";
	} else if(userCount > machineCount) {
		title = @"You've won!";
	} else {
		title = @"You loose!";
	}
	
	NSString *unformattedMessage = @"You: %d\nOpponent: %d";
	NSString *message = [NSString stringWithFormat:unformattedMessage, userCount, machineCount];
	
	UIAlertView *alert = [[[UIAlertView alloc]
						   initWithTitle:title
						   message:message
						   delegate:self
						   cancelButtonTitle:@"Play another!"
						   otherButtonTitles:nil] autorelease];
	
	[alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	for(SideView *side in self.sides) {
		[side reinit];
	}
	
	for(SquareView *square in self.squares) {
		[square reinit];
	}
	
	lastSideSelected = nil;
	
	[self giveTurn:TurnMachine];
}

- (void)drawRect:(CGRect)rect {
	[self initVertices];
	[self initSides];
	[self initSquares];

	[self giveTurn:TurnMachine];
}

- (void)dealloc {
	[squares release];
	[sides release];
	[vertices release];
	[lastSideSelected release];
    [super dealloc];
}

- (Color)userColor {
	return delegate.userColor;
}

- (Color)machineColor {
	return delegate.machineColor;
}

- (void)repaintSquares {
	for(SquareView *square in self.squares) {
		if(square.completed == YES) {
			[square repaint];
		}
	}
}

#pragma mark countSquaresToResign

- (int)countSquaresToResignByPlayingSide:(SideView *)side {
	int squaresToResign = 0;
	
	processedSquares = [[NSMutableArray alloc] init];
	
	if(side.square1 != nil) {
		squaresToResign += [self countSquaresToResignByPlayingSide:side inSquare:side.square1];
	}
	
	if(side.square2 != nil) {
		squaresToResign += [self countSquaresToResignByPlayingSide:side inSquare:side.square2];
	}
	
	[processedSquares release];
	
	return squaresToResign;
}

- (int)countSquaresToResignByPlayingSide:(SideView *)side inSquare:(SquareView *)square {
	//If it reached this far, then the machine already lost
	//one square.	
	int squaresToResign = 1; 

	SideView *otherUnmarkedSide = [self getOtherUnmarkedSideForSide:side
														   inSquare:square];

	SquareView *unprocessedSquare = nil;

	if(otherUnmarkedSide.square1 != square) {
		unprocessedSquare = otherUnmarkedSide.square1;
	} else {
		unprocessedSquare = otherUnmarkedSide.square2;
	}

	if(unprocessedSquare != nil) {
		if([processedSquares containsObject:unprocessedSquare] == NO) {
			[processedSquares addObject:unprocessedSquare];
		
			if([unprocessedSquare getSideCount] == 2) {
				squaresToResign += [self countSquaresToResignByPlayingSide:otherUnmarkedSide
																  inSquare:unprocessedSquare];
			}
		}
	}
	
	return squaresToResign;
}

- (SideView *)getOtherUnmarkedSideForSide:(SideView *)side inSquare:(SquareView *)square {
	
	NSArray *squareSides = [[[NSArray alloc] initWithObjects:square.side1,
															square.side2,
															square.side3,
															square.side4,
															nil] autorelease];
	
	for(SideView *squareSide in squareSides) {
		if(squareSide != nil) {
			if(squareSide != side && squareSide.marked == NO) {
				return squareSide;
			}
		}
	}

	//If execution reaches here, this is an error.
	NSLog(@"No unmarked side found.");
	return nil;
}

#pragma mark -

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	UITouch *touch = [touches anyObject];
	CGPoint currentPosition = [touch locationInView:self];

	//Find closest 2 vertices to the touch, get the side and mark it.
	VertexView *closestVertex = nil;
	CGFloat distanceToClosestVertex = MAXFLOAT;
	
	VertexView *secondClosestVertex = nil;
	CGFloat distanceToSecondClosestVertex = MAXFLOAT;

	for(VertexView *vertex in self.vertices) {
		CGFloat distanceToTouch = sqrt((currentPosition.x - vertex.frame.origin.x) * (currentPosition.x - vertex.frame.origin.x) +
									   (currentPosition.y - vertex.frame.origin.y) * (currentPosition.y - vertex.frame.origin.y));
		
		if(distanceToTouch < distanceToClosestVertex) {
			secondClosestVertex = closestVertex;
			distanceToSecondClosestVertex = distanceToClosestVertex;
			
			closestVertex = vertex;
			distanceToClosestVertex = distanceToTouch;
		} else if(distanceToTouch < distanceToSecondClosestVertex) {
			secondClosestVertex = vertex;
			distanceToSecondClosestVertex = distanceToTouch;
		}
	}
	
	SideView *side = [SideView getSideFromArray:self.sides
									withVertex1:closestVertex
									 andVertex2:secondClosestVertex];
	

	BOOL keepPlaying = [side markWithTurn:TurnUser andLatest:lastSideSelected];
	lastSideSelected = side;	
	
	if(keepPlaying == KeepPlayingYes) {
		[self giveTurn:TurnUser];
	} else {
		[self giveTurn:TurnMachine];
	}
}


@end
