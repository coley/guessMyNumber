//
//  Game.h
//  GuessMyNumber
//
//  Created by Nicole LaBonte on 10/4/11.
//  Copyright 2011 Nicole LaBonte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject

#pragma mark - Properties
@property (nonatomic, assign) NSInteger randomNumber;
@property (nonatomic, assign) NSInteger guessTotal;
@property (nonatomic, assign) NSInteger maximumGuess;
@property (nonatomic, assign) NSInteger minimumGuess;
@property (nonatomic, assign) BOOL guessCorrect;

#pragma mark - Methods
- (void)calculateRandomNumber;
- (double)calculateMinimumGuessAllowed:(double)minimumSliderRequested;
- (double)calculateMaximumGuessAllowed:(double)maximumSliderRequested;
- (NSString *)determineInstructionText;
- (NSString *)determineGuessTotalText;
- (NSString *)verifyGuess:(NSString *)guessInput;
- (double)convertStringToDouble:(NSString *)stringValue;
- (void)startGame;


@end
