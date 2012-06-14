//
//  GuessMyNumberViewController.h
//  GuessMyNumber
//
//  Created by Nicole LaBonte on 10/3/11.
//  Copyright 2011 Nicole LaBonte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuessMyNumberViewController : UIViewController   

#pragma mark - Properties
@property (nonatomic, strong) IBOutlet UILabel *labelInstruction;
@property (nonatomic, strong) IBOutlet UILabel *labelOutcome;
@property (nonatomic, strong) IBOutlet UILabel *labelGuessNumber;
@property (nonatomic, strong) IBOutlet UITextField *textInput;
@property (nonatomic, strong) IBOutlet UISlider *sliderMin;
@property (nonatomic, strong) IBOutlet UISlider *sliderMax;
@property (nonatomic, strong) NSMutableArray *games;

#pragma mark - IB Action Methods
- (IBAction)buttonGuess:(id)sender;
- (IBAction)sliderMinChange:(id)sender;
- (IBAction)sliderMaxChange:(id)sender;

#pragma mark - Support Methods
- (void)updateInstructionLabel;
- (void)verifyGuess:(NSString *)inputString;
- (void)resetGame;
- (void)submitGuess;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

#pragma mark - Initial Load Method
- (void)viewDidLoad;

@end
