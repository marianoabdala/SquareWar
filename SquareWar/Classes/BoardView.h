//
//  BoardView.h
//  SquareWar
//
//  Created by Mariano Abdala on 8/22/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SquareView.h"
#import "Enums.h"

@class SideView;
@protocol BoardViewDelegate;

#define kDotsSize		2		//Always pair.
#define kDotsSpacing	25
#define kDotsMarginX	17
#define kDotsMarginY	20

@interface BoardView : UIView<SquareViewDelegate> {
	NSArray *squares;
	NSMutableArray *sides;
	NSArray *vertices;
	
	SideView *lastSideSelected;
	NSMutableArray *processedSquares; //This is for counting.
	
	id<BoardViewDelegate> delegate;
}

@property (nonatomic, retain) NSArray *squares;
@property (nonatomic, retain) NSMutableArray *sides;
@property (nonatomic, retain) NSArray *vertices;
@property (nonatomic, retain) SideView *lastSideSelected;

@property (nonatomic, assign) id<BoardViewDelegate> delegate;

- (Color)userColor;
- (Color)machineColor;
- (void)repaintSquares;

@end

@protocol BoardViewDelegate<NSObject>
@optional
- (BOOL)boardViewIsPlaying:(BoardView *)view;
- (Color)userColor;
- (Color)machineColor;
- (GameDifficulty)gameDifficulty;
@end
