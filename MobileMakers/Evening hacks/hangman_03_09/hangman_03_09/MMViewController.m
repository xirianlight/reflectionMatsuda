//
//  MMViewController.m
//  hangman_03_09
//
//  Created by Ross Matsuda on 3/9/13.
//  Copyright (c) 2013 Genius and Madness. All rights reserved.
//

#import "MMViewController.h"

@interface MMViewController ()

@end

@implementation MMViewController
{
    //String manipulation
    NSString * userFacingMystery;
    NSString * mysteryWord;
    //Gameplay
    NSString * userGuessToProcess;
    int livesLeft;
    NSString * guessedLetters;
    
    //UI elements
    __weak IBOutlet UITextField *guessTextField;
    __weak IBOutlet UIButton *newGameButton;
    __weak IBOutlet UILabel *livesLeftLabel;
    __weak IBOutlet UILabel *guessedLettersLabel;
    //__weak IBOutlet UITextField *errorTextLabel;
    __weak IBOutlet UILabel *userFacingMysteryTextLabel;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self newGameSetup];
    

}

#pragma mark - Game setup process

-(void) getRandomWordFromInternet
{
    //JSON query for random word, 12 characters max
    //Includes personal API key
    NSString *wordnikURLString = @"http://api.wordnik.com//v4/words.json/randomWord?hasDictionaryDef=true&maxLength=12&api_key=57f4454e5bc62b0ecf60b0c9b2107cd240aed0680bcbc986e";
    
    
    //http://api.wordnik.com/v4/word.json/cat/definitions?api_key={your_key}
    //Code to go from URL string to JSON request
    NSURL *wordnikURL = [NSURL URLWithString:wordnikURLString];
    NSMutableURLRequest *wordnikURLRequest = [NSMutableURLRequest requestWithURL:wordnikURL];
    wordnikURLRequest.HTTPMethod = @"GET";
    [NSURLConnection sendAsynchronousRequest:wordnikURLRequest
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^void(NSURLResponse *myResponse, NSData *myData, NSError *myError)
     {
         if (myError)
         {
             NSLog(@"%@", myError.localizedDescription);
         }
         else
         {
             NSError *jsonError;
             id  genericObjectWeKnowIsDictionary =
             [NSJSONSerialization JSONObjectWithData:myData
                                             options:NSJSONReadingAllowFragments
                                               error:&jsonError];
             //Extract usable search results from raw JSON data
             NSDictionary * wordnikResult;
             wordnikResult = (NSMutableDictionary *) genericObjectWeKnowIsDictionary;
             //Set mysteryWord to lowercase version of random word
             mysteryWord = [NSString stringWithString:[[wordnikResult valueForKey:@"word"]lowercaseString]];
             NSLog( @"the mystery word is %@", mysteryWord);
             NSLog(@"The mystery word is %i characters long", mysteryWord.length);
             [self generateUserFacingMystery];

         }

     }];
}

- (IBAction)pressedNewGameButton:(id)sender
{
    [self newGameSetup];
}

-(void) newGameSetup
{
    livesLeft = 6;
    userFacingMystery = @"";
    newGameButton.hidden = YES;
    guessTextField.enabled = YES;
    guessedLettersLabel.text = @"";
    guessedLetters = @"";
    self.errorTextLabel.text = @"Guess a letter";
    [self getRandomWordFromInternet];
    [guessTextField becomeFirstResponder];
}

//Right now, this method is called only when getting a random word from the wordNik API
-(void) generateUserFacingMystery
{

    userFacingMystery = [[NSString string] stringByPaddingToLength:mysteryWord.length withString:@"*" startingAtIndex:0];
    NSLog(@"The userFacingMystery is %@", userFacingMystery);
    NSLog(@"The userFacingMystery is %i characters long", userFacingMystery.length);
    
    //Upon generating mystery, automatically display dashes if they are present 
    int j;
    for (j=0; j < mysteryWord.length; j++)
    {
        NSRange range = NSMakeRange(j, 1);
        NSString * rangeToCheckString = [mysteryWord substringWithRange:range];
        
        if ([rangeToCheckString isEqualToString: @"-"])
            
        {
            userFacingMystery = [userFacingMystery stringByReplacingCharactersInRange:range withString:@"-"];
            userFacingMysteryTextLabel.text = userFacingMystery;
            NSLog(@"Displayed dashes");
        }
        
    }
    
    
    userFacingMysteryTextLabel.text = userFacingMystery;
}


-(void)userMakesAGuess
{
    NSLog(@"The user guessed %@", guessTextField.text);
    //Make their guess lowercase, since the mystery has been made lowercase
    NSString * userGuess = [NSString stringWithString:[guessTextField.text lowercaseString]];
    userGuessToProcess = userGuess;
   
    //Error if field is empty
    if (userGuess.length == 0)
    {
        self.errorTextLabel.text = @"Please enter a letter";
        NSLog(@"Invalid guess: no input");
        livesLeft++;
    }
    
    //Now the hard one - anything not a lowercase letter
    //http://stackoverflow.com/questions/3605918/objective-c-check-for-unallowed-characters-in-string
    //The use of NSNotFound is because if they guess a letter that's not part of that string, the output will be "NSNotFound". So, if we see that, then they didn't guess a lowercase letter.
    
    NSCharacterSet * lowercaseLetters = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyz"];
    NSCharacterSet * everythingNotLowercaseLetters = [lowercaseLetters invertedSet];
    NSRange unacceptableGuesses = [userGuess rangeOfCharacterFromSet:everythingNotLowercaseLetters];
    
    if (unacceptableGuesses.location != NSNotFound)
        
    {
        NSLog(@"Not a lowercase lettter");
        self.errorTextLabel.text = @"Letters only";
        livesLeft++;
    }
    
    
    //Check if the guess is in the mystery word
    [self mysteryContainsLetter];
    
    
    //Finally, reset the text field.
    guessTextField.text = @"";
}


-(BOOL) mysteryContainsLetter
{
    //http://stackoverflow.com/questions/2753956/string-contains-string-in-objective-c
    //See if the mystery word contains, anywhere inside it, the userGuessToProcess. The return is a range, and if it's not there, it kicks out an NSNotFound
    
    if ([mysteryWord rangeOfString:userGuessToProcess].location != NSNotFound)
    {
        int i = 0;
        
        for (i=0; i < mysteryWord.length; i++)
        {
            NSRange range = NSMakeRange(i, 1);
            NSString * rangeToCheckString = [mysteryWord substringWithRange:range];
            NSLog (@"%@", rangeToCheckString);
            
            if ([rangeToCheckString isEqualToString: userGuessToProcess])

            {
                userFacingMystery= [userFacingMystery stringByReplacingCharactersInRange:range withString:userGuessToProcess];
                userFacingMysteryTextLabel.text = userFacingMystery;
                NSLog(@"The mystery search ran");
            }
            
        }
        //Win condition?
        [self didUserJustLose];
        NSLog(@"The mystery does contain the user's guess");
        return YES;
    }
    else
    {
        livesLeft--;
        livesLeftLabel.text = [NSString stringWithFormat:@"Lives Left: %i", livesLeft];
        
        //Did user already guess this wrong letter?
        if ([guessedLetters rangeOfString:userGuessToProcess].location != NSNotFound)
        {
            self.errorTextLabel.text = @"Already guessed that one";
            livesLeft++;
        }
        else{
            
        
        //Add letter to wrong guesses
        guessedLetters = [guessedLetters stringByAppendingString: [NSString stringWithFormat:@" %@",userGuessToProcess]];
        guessedLettersLabel.text = guessedLetters;
        }
        
        //Lose condition?
        [self didUserJustLose];
        NSLog(@"The user guessed incorrectly");
        return NO;
    }
}

-(void) didUserJustLose
{
    if (livesLeft == 0)
    {
        self.errorTextLabel.text = @"Game Over.";
        userFacingMysteryTextLabel.text = [NSString stringWithFormat:@"It was %@",mysteryWord];
        guessTextField.enabled = NO;
        newGameButton.hidden = NO;
        NSLog(@"Game over.");
    }
    
    if ([userFacingMysteryTextLabel.text isEqualToString:mysteryWord])
    {
        guessTextField.enabled = NO;
        newGameButton.hidden = NO;
        self.errorTextLabel.text = @"You won!";
        NSLog(@"User wins");
    }
}




#pragma mark - Keyboard behaviors

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
   // [guessTextField resignFirstResponder];
    [self userMakesAGuess];
    return YES;
}

//Only one character in text field!
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 1) ? NO : YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
