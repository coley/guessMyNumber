//
//  Game.m
//  GuessMyNumber
//
//  Created by Nicole LaBonte on 10/4/11.
//  Copyright 2011 Nicole LaBonte. All rights reserved.
//

#import "Game.h"

@implementation Game

#pragma mark - Synthesized properties
//  Synthesize properties
@synthesize randomNumber            = _randomNumber;
@synthesize guessTotal              = _guessTotal;
@synthesize maximumGuess            = _maximumGuess;
@synthesize minimumGuess            = _minimumGuess;
@synthesize guessCorrect            = _guessCorrect;


#pragma mark - Methods
/*
 *   This method generates a random number for the game and
 *   sets the randomNumber instance variable.
 */
- (void)calculateRandomNumber
{
    
    // Calculate random number
    self.randomNumber = (arc4random() % (self.maximumGuess - self.minimumGuess) + 1) + self.minimumGuess;
    
}

/*
 *  This method calculates the minimum slider value and sets
 *  the minimumGuess instance variable.
 */
- (double)calculateMinimumGuessAllowed:(double)minimumSliderRequested 
{
    //  Set variables
    double differentialAllowed = 5;
    double minimumSliderValue;
    double currentMaximum = (double) self.maximumGuess;
    
    //Calculate minimumGuess
    if (minimumSliderRequested <= currentMaximum - differentialAllowed && minimumSliderRequested > 0)
    {
        minimumSliderValue = minimumSliderRequested;

    } else
    {
        minimumSliderValue = currentMaximum - differentialAllowed;
    }
    
    //  Set minimum guess value
    self.minimumGuess = (int) minimumSliderValue;
    
    //  Return slider minimum value
    return minimumSliderValue;
}

/*
 *  This method calculates the maximum slider value and sets
 *  the maximumGuess instance variable.
 */
- (double)calculateMaximumGuessAllowed:(double)maximumSliderRequested 
{
    //  Set variables
    double differentialAllowed = 5;
    double maximumSliderValue;
    double currentMinimum = (double) self.minimumGuess;
    
    //Calculate maximumGuess
    if (maximumSliderRequested >= currentMinimum - differentialAllowed && maximumSliderRequested > 0)
    {
        maximumSliderValue = maximumSliderRequested;
        
    } else
    {
        maximumSliderValue = currentMinimum + differentialAllowed;
    }
    
    //  Set maximum guess value
    self.maximumGuess = (int) maximumSliderValue;
    
    //  Return slider maximum value
    return maximumSliderValue;
}

/*
 *  This method determines the instruction text 
 */
- (NSString *)determineInstructionText 
{
    //Create variable
    NSString *instructionMessage = [[NSString alloc] init];
    
    //Assign meesage
    instructionMessage = [NSString stringWithFormat:@"Guess a number between %i and %i", self.minimumGuess, self.maximumGuess];
    
    //Return instruction text
    return instructionMessage;
}

/*
 *  This method determines the number of guesses text 
 */
- (NSString *)determineGuessTotalText 
{
    //Create variable
    NSString *guessTotalText = [[NSString alloc] init];
    
    //Assign meesage
    guessTotalText = [NSString stringWithFormat:@"Guesses: %i", self.guessTotal];
    
    //Return guess text
    return guessTotalText;
}

/*
 *  This method verifies the guess 
 */
- (NSString *)verifyGuess:(NSString *)guessInput 
{
    //Create variable
    NSString *outcomeMessage = [[NSString alloc] init];
    double guessValue;
    
    //Assign variable
    self.guessCorrect = NO;
    
    //Convert guess input to a double
    guessValue = [self convertStringToDouble:guessInput];
    
    //Determine outcome message
    if (guessValue == (double) self.randomNumber)
    {
        outcomeMessage = [NSString stringWithFormat:@"Congrats! %@ is right!", guessInput];
        self.guessCorrect = YES;
        //[self startGame];
    } 
    else if (guessValue > (double) self.randomNumber)
    {
        outcomeMessage = [NSString stringWithFormat:@"%@ is too high.", guessInput];
    }
    else if (guessValue < (double) self.randomNumber && guessValue != 0)
    {
        outcomeMessage = [NSString stringWithFormat:@"%@ is too low.", guessInput];
    }
    else
    {
        outcomeMessage = [NSString stringWithFormat:@"%@ is an invalid guess.",guessInput];
    }
    
    
    //Return outcome message
    return outcomeMessage;
}


/*
 *  This method converts string to a double 
 */
- (double)convertStringToDouble:(NSString *)stringValue
{
    //Create variables
    double convertedValue;
    
    //Create number formatter
    NSNumberFormatter *doubleFormat = [[NSNumberFormatter alloc] init];
    
    //Set format style
    NSNumber *myNumber = [doubleFormat numberFromString:stringValue];
    
    
    //Convert user input
    convertedValue = [myNumber doubleValue];
    
    //Return double
    return convertedValue;

}

/*
 *  This method starts a new game
 */
- (void)startGame 
{
    //Calculate random number
    [self calculateRandomNumber];
    
    //Set total guess counter to 0
    self.guessTotal = 0;
    
}



/*
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
 */

@end
