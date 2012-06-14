//
//  GuessMyNumberViewController.m
//  GuessMyNumber
//
//  Created by Nicole LaBonte on 10/3/11.
//  Copyright 2011 Nicole LaBonte. All rights reserved.
//

#import "GuessMyNumberViewController.h"
#import "Game.h"

@implementation GuessMyNumberViewController

#pragma mark - Synthesized properties
@synthesize labelInstruction    = _labelInstruction;
@synthesize labelOutcome        = _labelOutcome;
@synthesize labelGuessNumber    = _labelGuessNumber;
@synthesize textInput           = _textInput;
@synthesize sliderMin           = _sliderMin;
@synthesize sliderMax           = _sliderMax;
@synthesize games               = _games;



#pragma mark - IB Action Methods
/*
 *  This method handles the button guess tap.
 *  It sends a message to submitGuess.
 */
- (IBAction)buttonGuess:(id)sender
{    
    
    [self submitGuess];
    
}

/*
 *  This method handles a change to the minimum slider.
 *  It obtains the game object, applies a valid minimum
 *  slider value, resets the game due to range change, 
 *  updates outcome text to indicate a new game was started,
 *  and updates the guess couunt message.
 */
- (IBAction)sliderMinChange:(id)sender
{
    //Declare variables
    NSString *guessCountMessage = [[NSString alloc] init];
    
    //Slider object
    UISlider *slider = (UISlider *)sender;
    
    //Obtain games object
    Game *myGame = [self.games objectAtIndex:0];
    
    //Set variables
    double validSliderValue;
    
    //Determine minimum slider value
    validSliderValue = [myGame calculateMinimumGuessAllowed:slider.value];
    
    //Set slider minimum
    self.sliderMin.value = validSliderValue;
    
    //Display new game message
    self.labelOutcome.text = [NSString stringWithFormat:@"New Game Started"];
    
    //Reset game based on new values
    [self resetGame];
    
    //Update guess count text
    guessCountMessage = [myGame determineGuessTotalText];
    self.labelGuessNumber.text = guessCountMessage;

}

/*
 *  This method handles a change to the maximum slider.
 *  It obtains the game object, applies a valid maximum
 *  slider value, resets the game due to range change, 
 *  updates outcome text to indicate a new game was started,
 *  and updates the guess couunt message.
 */
- (IBAction)sliderMaxChange:(id)sender
{
    //Declare variables
    NSString *guessCountMessage = [[NSString alloc] init];
    
    //Slider object
    UISlider * slider = (UISlider *)sender;
    
    //Obtain games object
    Game *myGame = [self.games objectAtIndex:0];
    
    //Set variables
    double validSliderValue;
    
    //Determine minimum slider value
    validSliderValue = [myGame calculateMaximumGuessAllowed:slider.value];
    
    //Set slider maximum
    self.sliderMax.value = validSliderValue;
    
    //Display new game message
    self.labelOutcome.text = [NSString stringWithFormat:@"New Game Started"];
    
    //Reset game based on new values
    [self resetGame];
    
    //Update guess count text
    guessCountMessage = [myGame determineGuessTotalText];
    self.labelGuessNumber.text = guessCountMessage;
    
}

#pragma mark - Support Methods
/*
 *  This method updates the instruction label text.
 *  It obtains the game object and sends a message
 *  to the method to determine message for instruction text.
 */
- (void)updateInstructionLabel
{
    //Create output variable
    NSString *outputMessage = [[NSString alloc] init];
    
    //Obtain games object
    Game *myGame = [self.games objectAtIndex:0];
    
    //Assign output message   
    outputMessage = [myGame determineInstructionText];
    
    //Update instruction label
    self.labelInstruction.text = outputMessage;
}


/*
 *  This method verifies the user's guess.  
 *  It obtains the game object, sends a message
 *  to verify the user's input and sends a message
 *  to reset game if the guess is correct.
 */
- (void)verifyGuess:(NSString *)inputString
{    
    //Create variables
    NSString *outputMessage = [[NSString alloc] init];
    BOOL guessCorrect;
    
    //Obtain games object
    Game *myGame = [self.games objectAtIndex:0];
    
    //Set output message
    outputMessage = [myGame verifyGuess:inputString];
    
    //Update output message label
    self.labelOutcome.text = outputMessage;
    
    //Set guess correct
    guessCorrect = [myGame guessCorrect];
    
    //Set text field to no data
    self.textInput.text = @"";
    
    //Determine if reset should occur
    if (guessCorrect) 
    {
        [self resetGame];
    }
}

/*
 *  This method resets the game.
 *  This method gets the game object and starts a 
 *  a message to start a new game.  It does not change
 *  the outcome label or number of guesses label so that
 *  this data can still be viewed after the game is won.
 */
- (void)resetGame
{
    //Declare variables
    NSString *textFieldPlaceholoder = [[NSString alloc] init];
    
    //Obtain games object
    Game *myGame = [self.games objectAtIndex:0];
    
    //Reset text entry to nothing
    self.textInput.text = @"";
    
    //Start new game
    [myGame startGame];
    
    //Reset instruction text
    [self updateInstructionLabel];
    
    //Set placeholder text in text field
    textFieldPlaceholoder = [NSString stringWithFormat:@"New Game"];
    self.textInput.placeholder = textFieldPlaceholoder;
    
}


/*
 *  This method handles guess submissions.
 *  This method references the game object, 
 *  updates the guess count, updates the guess count
 *  label, updates the text field placeholder text,
 *  and sends a message to verify guess.
 */
- (void)submitGuess
{
    //Obtain games object
    Game *myGame = [self.games objectAtIndex:0];
    
    //Declare variables
    int guessCount;
    NSString *userGuess = [[NSString alloc] init];
    NSString *guessCountMessage = [[NSString alloc] init];
    NSString *textFieldPlaceholoder = [[NSString alloc] init];
    
    //Find current guess count
    guessCount = [myGame guessTotal];
    
    //Add 1 to guess count
    guessCount++;
    [myGame setGuessTotal:guessCount];
    
    //Update guess count text
    guessCountMessage = [myGame determineGuessTotalText];
    self.labelGuessNumber.text = guessCountMessage;
    
    //Set placeholder text
    textFieldPlaceholoder = [NSString stringWithFormat:@"enter guess"];
    self.textInput.placeholder = textFieldPlaceholoder;
    
    //Obtain user guess
    userGuess = self.textInput.text;
    
    //Verify guess
     [self verifyGuess:userGuess];
    
}


/*
 *  This method clicking the return button while in the
 *  text field.  It will call the submit guess method.
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textInput 
{
    [self submitGuess];
    
    return YES;
}

#pragma mark - Initial Load

/*
 *  This method performs the initial load functions.
 *  It sets the initial maximum and minimum guess range.
 *  It allocates the games array and createa a new
 *  game object, which is passed into this array.
 *  It starts a new game and sets the text field
 *  to be the first responder.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Create variables
    int maximumGuess = 100;
    int minimumGuess = 1;
    
    //Allocate games array
    self.games = [[NSMutableArray alloc] init];
    
    //Create game object
    Game *myGame = [[Game alloc] init];
    
    //Set min and maximum guesses
    [myGame setMaximumGuess:maximumGuess];
    [myGame setMinimumGuess:minimumGuess];
    
    //Start game
    [myGame startGame];

    //Assign myGame to games array
    [self.games addObject:myGame];
    
    //Set text field for first responder
    [self.textInput becomeFirstResponder];
}


 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
     // Return YES for supported orientations
     return YES;
 }



@end