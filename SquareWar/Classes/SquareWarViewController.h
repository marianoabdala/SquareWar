//
//  SquareWarViewController.h
//  SquareWar
//
//  Created by Mariano Abdala on 8/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoardView.h"
#import "Enums.h"

#define kPreferredUserColorKey @"userSelectedColor"
#define kPreferredMachineColorKey @"machineSelectedColor"
#define kPreferredGameDifficulty @"gameDifficulty"

@interface SquareWarViewController : UIViewController<UIScrollViewDelegate, BoardViewDelegate> {
	IBOutlet UIScrollView *gameScrollView;
	IBOutlet UIView *scrollableView;
	IBOutlet UILabel *instructionsLabel;
	IBOutlet UISegmentedControl *difficultySegmentedControl;
	IBOutlet BoardView *boardView;

	IBOutlet UIButton *userBlueButton;
	IBOutlet UIButton *userCyanButton;
	IBOutlet UIButton *userGreenButton;
	IBOutlet UIButton *userYellowButton;
	IBOutlet UIButton *userOrangeButton;
	IBOutlet UIButton *userRedButton;
	IBOutlet UIButton *userPurpleButton;
	IBOutlet UIButton *userMagentaButton;

	IBOutlet UIButton *machineBlueButton;
	IBOutlet UIButton *machineCyanButton;
	IBOutlet UIButton *machineGreenButton;
	IBOutlet UIButton *machineYellowButton;
	IBOutlet UIButton *machineOrangeButton;
	IBOutlet UIButton *machineRedButton;
	IBOutlet UIButton *machinePurpleButton;
	IBOutlet UIButton *machineMagentaButton;
	
	GameStatus gameStatus;
	Color userSelectedColor;
	Color machineSelectedColor;
	GameDifficulty gameDifficulty;
}

@property (nonatomic, retain) UIScrollView *gameScrollView;
@property (nonatomic, retain) UIView *scrollableView;
@property (nonatomic, retain) UILabel *instructionsLabel;
@property (nonatomic, retain) UISegmentedControl *difficultySegmentedControl;
@property (nonatomic, retain) BoardView *boardView;

@property (nonatomic, retain) UIButton *userBlueButton;
@property (nonatomic, retain) UIButton *userCyanButton;
@property (nonatomic, retain) UIButton *userGreenButton;
@property (nonatomic, retain) UIButton *userYellowButton;
@property (nonatomic, retain) UIButton *userOrangeButton;
@property (nonatomic, retain) UIButton *userRedButton;
@property (nonatomic, retain) UIButton *userPurpleButton;
@property (nonatomic, retain) UIButton *userMagentaButton;

@property (nonatomic, retain) UIButton *machineBlueButton;
@property (nonatomic, retain) UIButton *machineCyanButton;
@property (nonatomic, retain) UIButton *machineGreenButton;
@property (nonatomic, retain) UIButton *machineYellowButton;
@property (nonatomic, retain) UIButton *machineOrangeButton;
@property (nonatomic, retain) UIButton *machineRedButton;
@property (nonatomic, retain) UIButton *machinePurpleButton;
@property (nonatomic, retain) UIButton *machineMagentaButton;

@property (nonatomic, assign) GameStatus gameStatus;
@property (nonatomic, assign) Color userSelectedColor;
@property (nonatomic, assign) Color machineSelectedColor;
@property (nonatomic, assign) GameDifficulty gameDifficulty;

- (IBAction)userColorButtonPressed:(id)sender;
- (IBAction)machineColorButtonPressed:(id)sender;
- (IBAction)difficultySegmentedControlValueChanged:(id)sender;

- (Color)userColor;
- (Color)machineColor;
- (GameDifficulty)gameDifficulty;

@end

