//
//  SquareWarViewController.m
//  SquareWar
//
//  Created by Mariano Abdala on 8/21/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "SquareWarViewController.h"

@interface SquareWarViewController (PrivateAPI)
- (void)setPlayZoom:(UIScrollView *)scrollView;
- (void)setOptionsZoom:(UIScrollView *)scrollView;
- (void)clearUserSelectedColor;
- (void)clearMachineSelectedColor;
- (void)loadPreferences;
@end

@implementation SquareWarViewController
@synthesize gameScrollView;
@synthesize scrollableView;
@synthesize instructionsLabel;
@synthesize boardView;
@synthesize difficultySegmentedControl;

@synthesize userBlueButton;
@synthesize userCyanButton;
@synthesize userGreenButton;
@synthesize userYellowButton;
@synthesize userOrangeButton;
@synthesize userRedButton;
@synthesize userPurpleButton;
@synthesize userMagentaButton;

@synthesize machineBlueButton;
@synthesize machineCyanButton;
@synthesize machineGreenButton;
@synthesize machineYellowButton;
@synthesize machineOrangeButton;
@synthesize machineRedButton;
@synthesize machinePurpleButton;
@synthesize machineMagentaButton;

@synthesize gameStatus;
@synthesize userSelectedColor;
@synthesize machineSelectedColor;
@synthesize gameDifficulty;

// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (void)viewDidLoad {
	[self setPlayZoom:self.gameScrollView];
	self.boardView.delegate = self;
	
	[self loadPreferences];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return scrollableView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
					   withView:(UIView *)view
						atScale:(float)scale {

	scrollView.zoomScale = 2.0f;
	
	if(self.gameStatus == GameStatusPlaying) {
		if(scale < 1.7) {
			[self setOptionsZoom:scrollView];
		} else {
			[self setPlayZoom:scrollView];
		}
	} else { //self.gameStatus == GameStatusSettingOptions
		if(scale > 1.3) {
			[self setPlayZoom:scrollView];
		} else {
			[self setOptionsZoom:scrollView];
		}
	}
}

- (void)setPlayZoom:(UIScrollView *)scrollView {
	self.gameStatus = GameStatusPlaying;
	scrollView.zoomScale = 2.0f;
	scrollView.contentOffset = CGPointMake(160, 240);
	self.instructionsLabel.text = @"Pinch in for options";
	self.boardView.userInteractionEnabled = YES;
}

- (void)setOptionsZoom:(UIScrollView *)scrollView {
	self.boardView.userInteractionEnabled = NO;
	self.gameStatus = GameStatusSettingOptions;
	scrollView.zoomScale = 1.0f;
	scrollView.contentOffset = CGPointMake(0, 0);
	self.instructionsLabel.text = @"Pinch out to continue playing";
}

- (BOOL)boardViewIsPlaying:(BoardView *)view {
	return self.gameStatus == GameStatusPlaying;
}

- (IBAction)userColorButtonPressed:(id)sender {
	[self clearUserSelectedColor];
	
	UIButton *button = (UIButton *)sender;
	button.selected = YES;
	
	self.userSelectedColor = (Color)button.tag;

	[[NSUserDefaults standardUserDefaults] setInteger:self.userSelectedColor
											   forKey:kPreferredUserColorKey];
	
	[self.boardView repaintSquares];
}

- (IBAction)machineColorButtonPressed:(id)sender {
	[self clearMachineSelectedColor];
	
	UIButton *button = (UIButton *)sender;
	button.selected = YES;
	
	self.machineSelectedColor = (Color)button.tag;

	[[NSUserDefaults standardUserDefaults] setInteger:self.machineSelectedColor
											   forKey:kPreferredMachineColorKey];
	
	[self.boardView repaintSquares];
}

- (IBAction)difficultySegmentedControlValueChanged:(id)sender {
	self.gameDifficulty = (GameDifficulty)difficultySegmentedControl.selectedSegmentIndex + 1; //0 based for the index, but the enum starts at 1.
	
	[[NSUserDefaults standardUserDefaults] setInteger:self.gameDifficulty
											   forKey:kPreferredGameDifficulty];
}

- (void)clearUserSelectedColor {
	self.userBlueButton.selected = NO;
	self.userCyanButton.selected = NO;
	self.userGreenButton.selected = NO;
	self.userYellowButton.selected = NO;
	self.userOrangeButton.selected = NO;
	self.userRedButton.selected = NO;
	self.userPurpleButton.selected = NO;
	self.userMagentaButton.selected = NO;
}

- (void)clearMachineSelectedColor {
	self.machineBlueButton.selected = NO;
	self.machineCyanButton.selected = NO;
	self.machineGreenButton.selected = NO;
	self.machineYellowButton.selected = NO;
	self.machineOrangeButton.selected = NO;
	self.machineRedButton.selected = NO;
	self.machinePurpleButton.selected = NO;
	self.machineMagentaButton.selected = NO;
}

- (void)loadPreferences {
	self.userSelectedColor = (Color)[[NSUserDefaults standardUserDefaults] integerForKey:kPreferredUserColorKey];
	
	if(self.userSelectedColor == 0) { //Not preference found.
		self.userSelectedColor = ColorBlue;
		[[NSUserDefaults standardUserDefaults] setInteger:self.userSelectedColor
												   forKey:kPreferredUserColorKey];
	}
	
	self.machineSelectedColor = (Color)[[NSUserDefaults standardUserDefaults] integerForKey:kPreferredMachineColorKey];

	if(self.machineSelectedColor == 0) { //Not preference found.
		self.machineSelectedColor = ColorRed;
		[[NSUserDefaults standardUserDefaults] setInteger:self.machineSelectedColor
												   forKey:kPreferredMachineColorKey];
	}
	
	self.gameDifficulty = (GameDifficulty)[[NSUserDefaults standardUserDefaults] integerForKey:kPreferredGameDifficulty];
	
	if(self.gameDifficulty == 0) { //Not preference found.
		self.gameDifficulty = GameDifficultyMedium;
		[[NSUserDefaults standardUserDefaults] setInteger:self.gameDifficulty
												   forKey:kPreferredGameDifficulty];
	}
	
	UIButton *userButtonToSelect = nil;
	
	switch (self.userSelectedColor) {
		case ColorBlue:
			userButtonToSelect = self.userBlueButton;
			break;
		case ColorCyan:
			userButtonToSelect = self.userCyanButton;
			break;
		case ColorGreen:
			userButtonToSelect = self.userGreenButton;
			break;
		case ColorYellow:
			userButtonToSelect = self.userYellowButton;
			break;
		case ColorOrange:
			userButtonToSelect = self.userOrangeButton;
			break;
		case ColorRed:
			userButtonToSelect = self.userRedButton;
			break;
		case ColorPurple:
			userButtonToSelect = self.userPurpleButton;
			break;
		case ColorMagenta:
			userButtonToSelect = self.userMagentaButton;
			break;
	}
	
	userButtonToSelect.selected = YES;

	UIButton *machineButtonToSelect = nil;
	
	switch (self.machineSelectedColor) {
		case ColorBlue:
			machineButtonToSelect = self.machineBlueButton;
			break;
		case ColorCyan:
			machineButtonToSelect = self.machineCyanButton;
			break;
		case ColorGreen:
			machineButtonToSelect = self.machineGreenButton;
			break;
		case ColorYellow:
			machineButtonToSelect = self.machineYellowButton;
			break;
		case ColorOrange:
			machineButtonToSelect = self.machineOrangeButton;
			break;
		case ColorRed:
			machineButtonToSelect = self.machineRedButton;
			break;
		case ColorPurple:
			machineButtonToSelect = self.machinePurpleButton;
			break;
		case ColorMagenta:
			machineButtonToSelect = self.machineMagentaButton;
			break;
	}
	
	machineButtonToSelect.selected = YES;
	
	switch (self.gameDifficulty) {
		case GameDifficultyEasy:
			self.difficultySegmentedControl.selectedSegmentIndex = 0;
			break;
		case GameDifficultyMedium:
			self.difficultySegmentedControl.selectedSegmentIndex = 1;
			break;
		case GameDifficultyHard:
			self.difficultySegmentedControl.selectedSegmentIndex = 2;
			break;
	}
}

- (Color)userColor {
	return self.userSelectedColor;
}

- (Color)machineColor {
	return self.machineSelectedColor;
}

- (void)dealloc {
	[gameScrollView release];
	[scrollableView release];
	[instructionsLabel release];
	[boardView release];
	[difficultySegmentedControl release];
	
	[userBlueButton release];
	[userCyanButton release];
	[userGreenButton release];
	[userYellowButton release];
	[userOrangeButton release];
	[userRedButton release];
	[userPurpleButton release];
	[userMagentaButton release];
	
	[machineBlueButton release];
	[machineCyanButton release];
	[machineGreenButton release];
	[machineYellowButton release];
	[machineOrangeButton release];
	[machineRedButton release];
	[machinePurpleButton release];
	[machineMagentaButton release];
	
    [super dealloc];
}

@end
