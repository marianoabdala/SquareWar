/*
 *  Enums.h
 *  SquareWar
 *
 *  Created by Mariano Abdala on 9/9/09.
 *  Copyright 2009 __MyCompanyName__. All rights reserved.
 *
 */

typedef enum {
    TurnUser,
    TurnMachine
} Turn;

typedef enum {
	KeepPlayingNo,
	KeepPlayingYes
} KeepPlaying;

typedef enum {
	GameStatusPlaying,
	GameStatusSettingOptions
} GameStatus;

typedef enum {
	ColorBlue = 1,
	ColorCyan = 2,
	ColorGreen = 3,
	ColorYellow = 4,
	ColorOrange = 5,
	ColorRed = 6,
	ColorPurple = 7,
	ColorMagenta = 8
} Color;

typedef enum {
	GameDifficultyEasy = 1,
	GameDifficultyMedium = 2,
	GameDifficultyHard = 3
} GameDifficulty;
