//
//  BoardGamePlayer.h
//  SueVSWorld
//
//  Created by Don Bora on 1/16/12.
//  Copyright (c) 2012 Eight Bit Studios. All rights reserved.
//

#import <Foundation/Foundation.h> // Import OBjective C Code
#import "GameCard.h" // Import custom file (not )

@class ManagedObjectFactory; // Da' fuq is this??

@interface BoardGamePlayer : NSObject // We're defining BoardGamePlayer class, based on NSObject
{
    
    NSMutableArray*         mDeckCards;  //Make a mutable array for Deck cards left
    NSMutableArray*         mHandCards; // Make a mutable array for the cards in your hand
    NSMutableArray*         mDeck; // Make a mutable array for the deck ITSELF
 
    ManagedObjectFactory*   mManagedObjectFactory;
    GameCard*               mPlayCard; // Object gamecard (imported above) for a card to play
    Game*                   mGame; // Object for the game itself? Maybe?
    
    BOOL                    mPlayedFirstCard; // Boolean for first card played, true or false

    int                     mPlayer; // int for current player? Or player in general
}

@property(nonatomic, readonly)int player; // Setting properties! We have a player for the boardGaemPlayer
@property(nonatomic, retain)NSMutableArray* deckCards; // We have a deck of cards
@property(nonatomic, retain)NSMutableArray* handCards; // and a hand
@property(nonatomic, retain)NSMutableArray* deck; // and a deck again?              WHAT'S UP WITH PROPERTIES?
@property(nonatomic, retain)GameCard* playCard; // a played card
@property(nonatomic, retain)Game* game; // the game intance itself
@property(nonatomic, assign)BOOL playedFirstCard;  // Which card got played first

-(id)init:(int)player game:(Game*)game; // initialize the game? Method for game #

-(void)playCard:(GameCard*)gameCard; // method for playing a card
-(void)discard:(GameCard*)gameCard; // method for discarding
-(void)moveCardToOnDeck:(GameCard*)gameCard forHandPosition:(int)handPosition; // method for moving a card onto the deck from hand
-(void)swapPlayCardWithOnDeckCard:(GameCard*)gameCard; // swap card for one on the deck method
-(void)reset:(Game*)game; // reset the game method

-(BOOL)hasBoosterCard; // Does the instance have a booser
-(BOOL)hasBackupCard; // does the instance have a backup
-(BOOL)hasPlayCard; // Has the player played a card?

-(NSArray*)cards; // Array for holding all cards?
-(NSArray*)drawCards; // Array for holding cards moving to hand? Or the card BEING drawn?
@end


@interface BoardGamePlayer (Private) // Another class?!
-(void)__loadCardsIntoDeckWithPredicateString:(NSString*)predicateString andNumberOfCards:(int)numberOfCards; // load cards from array into deck
-(void)swapPlayCardWithOnDeckCard:(GameCard*)gameCard; // Method to move play card to the deck
-(void)__pullCharacterCardsToTopOfDeck; // Ability to mvoe character cards to top of deck
-(void)__restoreCards; // move cards back to hand
-(BOOL)__loadCardsIntoDeck; // move cards into deck from somewhere
@end