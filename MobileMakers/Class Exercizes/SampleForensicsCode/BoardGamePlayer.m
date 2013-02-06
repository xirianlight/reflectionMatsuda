//
//  BoardGamePlayer.m
//  SueVSWorld
//
//  Created by Don Bora on 1/16/12.
//  Copyright (c) 2012 Eight Bit Studios. All rights reserved.
//

#import "BoardGamePlayer.h"
#import "ManagedObjectFactory.h"
#import "NSMutableArray+Shuffling.h"
#import "Constants.h"
#import "GameCard.h"
#import "ImmutableCard.h"
#import "PrimaryAction.h"
#import "SecondaryAction.h"
#import "BoardGameEngine.h"

@implementation BoardGamePlayer

@synthesize player = mPlayer;
@synthesize deckCards = mDeckCards;
@synthesize handCards = mHandCards;
@synthesize deck = mDeck;
@synthesize playCard = mPlayCard;
@synthesize playedFirstCard = mPlayedFirstCard;
@synthesize game = mGame; // USE THE STUFF FROM THE .h files

-(id)init:(int)player game:(Game*)game
{
    if ((self = [super init])) {
        NSMutableArray* array; //create a mutable array named array
        
        mManagedObjectFactory = [ManagedObjectFactory sharedInstance];
        self.game = game;        
        
        array = [[NSMutableArray alloc] initWithCapacity:40]; //create a 40 card deck
        self.deck = array;
        [array release];
        
        array = [[NSMutableArray alloc] initWithCapacity:3]; // 3 deck cards set aside
        self.deckCards = array;
        [array release];
        
        array = [[NSMutableArray alloc] initWithCapacity:5];  // 5 cards in your hand
        self.handCards = array;
        [array release];
        
       // self.deckCards = [[NSMutableArray alloc] initWithCapacity:3];
       // self.handCards = [[NSMutableArray alloc] initWithCapacity:5];
        mPlayer = player;  // no idea

        if ([self __loadCardsIntoDeck]) {  // If you're supposed to put cards into deck, draw cards, otherwise restore theM?
            [self drawCards];
        }
        else{
            [self __restoreCards];
        }
        
    }
                 
    return self;
}

 // indicator, instance method, returns void, method name is setPlayCard, parameter type is GameCard, 
-(void)setPlayCard:(GameCard *)playCard
{
    [mPlayCard release];
    mPlayCard = nil;
    
    if (playCard != nil && playCard  != mPlayCard) {
        mPlayCard = playCard;
        [mPlayCard retain];
    }

    [mHandCards removeObject:playCard];
    [mDeckCards removeObject:playCard];
}

-(void)playCard:(GameCard*)gameCard
{
    [mHandCards removeObject:gameCard];
    [mDeckCards removeObject:gameCard];

    if (!mPlayedFirstCard) {
        mPlayedFirstCard = YES;
        self.playCard = gameCard;
        [mManagedObjectFactory commit];
    }
}


-(NSArray*)drawCards
{   
    if (!mPlayedFirstCard || [mGame.turnCount intValue] > 0) {
        int handPosition = CARD_IN_HAND_POSITION_1;
        
        while ([mHandCards count] < 5) {
            GameCard* gameCard = (GameCard*)[mDeck objectAtIndex:0];
            [mHandCards addObject:gameCard];
            [mDeck removeObjectAtIndex:0];
            //[mDeck removeObject:gameCard];
        }
        
        for (GameCard* gameCard in mHandCards){
            //NSLog(@"drawCards(before):%@  handPosition=%i", gameCard.immutableCard.name, [gameCard.handPosition intValue]);
            //if ([gameCard.handPosition intValue] != 0 && ([gameCard.handPosition intValue] != handPosition) && ([gameCard.handPosition intValue] < CARD_IN_HAND_POSITION_1)) {
            //    NSLog(@"about to change it");
            //}
            gameCard.handPosition = [NSNumber numberWithInt:handPosition];
            //NSLog(@"drawCards(after):%@  handPosition=%i", gameCard.immutableCard.name, [gameCard.handPosition intValue]);
            handPosition++;
        }
        
        [mManagedObjectFactory commit];
    }
    return mHandCards;
}

-(void)moveCardToOnDeck:(GameCard*)gameCard forHandPosition:(int)handPosition
{
    if ([mDeckCards count] < 3) {
        [mHandCards removeObject:gameCard];
        [mDeckCards addObject:gameCard];
        
        //NSLog(@"moveCardToOnDeckß(before):%@  handPosition=%i", gameCard.immutableCard.name, [gameCard.handPosition intValue]);
        gameCard.handPosition = [NSNumber numberWithInt:handPosition];
        //NSLog(@"moveCardToOnDeckß(after):%@  handPosition=%i", gameCard.immutableCard.name, [gameCard.handPosition intValue]);
        [mManagedObjectFactory commit];
    }
}


-(void)swapPlayCardWithOnDeckCard:(GameCard*)gameCard
{
    int backHandPosition = [gameCard.handPosition intValue];
    int playHandPosition = [mPlayCard.handPosition intValue];
    
    //NSLog(@"swapPlayCardWithOnDeckCard(before):%@  handPosition=%i", gameCard.immutableCard.name, [gameCard.handPosition intValue]);
    gameCard.handPosition = [NSNumber numberWithInt:playHandPosition];
    //NSLog(@"swapPlayCardWithOnDeckCard(after):%@  handPosition=%i", gameCard.immutableCard.name, [gameCard.handPosition intValue]);
    //NSLog(@"swapPlayCardWithOnDeckCard(before):%@  handPosition=%i", mPlayCard.immutableCard.name, [mPlayCard.handPosition intValue]);
    mPlayCard.handPosition = [NSNumber numberWithInt:backHandPosition];
    //NSLog(@"swapPlayCardWithOnDeckCard(after):%@  handPosition=%i", mPlayCard.immutableCard.name, [mPlayCard.handPosition intValue]);
    
    [mDeckCards removeObject:gameCard];
    [mDeckCards addObject:mPlayCard];
    
    self.playCard = gameCard;
    
    [mManagedObjectFactory commit];
}



-(BOOL)hasPlayCard
{
    return mPlayCard != nil;
}

-(void)discard:(GameCard*)gameCard
{
    if (mPlayCard == gameCard) {
        self.playCard = nil;
    }
    else{
        [mHandCards removeObject:gameCard];
        [mDeckCards removeObject:gameCard];
    }

    //NSLog(@"discard(before):%@  handPosition=%i", gameCard.immutableCard.name, [gameCard.handPosition intValue]);
    gameCard.handPosition = [NSNumber numberWithInt:0];
    //NSLog(@"discard(before):%@  handPosition=%i", gameCard.immutableCard.name, [gameCard.handPosition intValue]);
    gameCard.discarded = [NSNumber numberWithBool:YES];
    [mManagedObjectFactory commit];
}


-(NSArray*)cards
{
    NSMutableString* predicateString = [NSMutableString stringWithCapacity:1];
    
    [predicateString appendFormat:@"discarded == 0 && player == %i  && (handPosition == %i || handPosition == %i || handPosition == %i || handPosition == %i || handPosition == %i || handPosition == %i || handPosition == %i || handPosition == %i || handPosition == %i)", mPlayer, CARD_IN_PLAY_POSITION, CARD_ON_DECK_POSITION_1, CARD_ON_DECK_POSITION_2, CARD_ON_DECK_POSITION_3, CARD_IN_HAND_POSITION_1, CARD_IN_HAND_POSITION_2, CARD_IN_HAND_POSITION_3, CARD_IN_HAND_POSITION_4, CARD_IN_HAND_POSITION_5];
    
    return [mManagedObjectFactory entitiesNamed:sGameCardEntity withPredicate:[NSPredicate predicateWithFormat:predicateString] sortedOn:nil ascending:YES];
}


-(void)reset:(Game*)game
{
    [mDeckCards removeAllObjects];
    [mHandCards removeAllObjects];
    [mDeck removeAllObjects];
    
    self.playCard = nil;
    self.game = game;
    
    mPlayedFirstCard = NO;
    
    //mDeck = [NSMutableArray arrayWithCapacity:40];
    //[mDeck retain];
    
    [self __loadCardsIntoDeck];
    [self drawCards];
}


-(void)dealloc
{
    self.game = nil;
    self.playCard = nil;
    
    [mDeckCards removeAllObjects];
    [mDeckCards release];

    [mDeck removeAllObjects];
    [mDeck release];

    [mHandCards removeAllObjects];
    [mHandCards release];
    [super dealloc];
}

#pragma mark (Private)

-(BOOL)hasBoosterCard
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"discarded == 0 && player == %i && (immutableCard.type == %i || immutableCard.type == %i || immutableCard.type == %i || immutableCard.type == %i) && (handPosition >= %i && handPosition <= %i)", mPlayer, CARD_TYPE_BOOSTER_ANTHROPOLOGY, CARD_TYPE_BOOSTER_BOTANY, CARD_TYPE_BOOSTER_GEOLOGY, CARD_TYPE_BOOSTER_ZOOLOGY, CARD_IN_HAND_POSITION_1, CARD_IN_HAND_POSITION_5]];
    NSArray* cards = [mManagedObjectFactory entitiesNamed:sGameCardEntity withPredicate:predicate sortedOn:nil ascending:YES];
    
    return ([cards count] > 0) ? YES : NO;
}


-(BOOL)hasBackupCard
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"discarded == 0 && player == %i && (handPosition == %i || handPosition == %i || handPosition == %i)", mPlayer, CARD_ON_DECK_POSITION_1, CARD_ON_DECK_POSITION_2, CARD_ON_DECK_POSITION_3]];
    NSArray* cards = [mManagedObjectFactory entitiesNamed:sGameCardEntity withPredicate:predicate sortedOn:nil ascending:YES];
    
    return ([cards count] > 0) ? YES : NO;
}


-(void)__restoreCards
{
    NSMutableString* predicateString;
    NSArray* cards;
    
    predicateString = [NSString stringWithFormat:@"discarded == 0 && player == %i  && (handPosition == 0 || handPosition = nil)", mPlayer];
    mDeck =  [NSMutableArray arrayWithArray:[mManagedObjectFactory entitiesNamed:sGameCardEntity withPredicate:[NSPredicate predicateWithFormat:predicateString] sortedOn:nil ascending:YES]];
    [mDeck retain];
    
    predicateString = [NSString stringWithFormat:@"discarded == 0 && player == %i  && (handPosition == %i || handPosition == %i || handPosition == %i)", mPlayer, CARD_ON_DECK_POSITION_1, CARD_ON_DECK_POSITION_2, CARD_ON_DECK_POSITION_3];
    mDeckCards =  [NSMutableArray arrayWithArray:[mManagedObjectFactory entitiesNamed:sGameCardEntity withPredicate:[NSPredicate predicateWithFormat:predicateString] sortedOn:nil ascending:YES]];
    [mDeckCards retain];
    
    predicateString = [NSString stringWithFormat:@"discarded == 0 && player == %i  && (handPosition == %i || handPosition == %i || handPosition == %i || handPosition == %i || handPosition == %i)", mPlayer, CARD_IN_HAND_POSITION_1, CARD_IN_HAND_POSITION_2, CARD_IN_HAND_POSITION_3, CARD_IN_HAND_POSITION_4, CARD_IN_HAND_POSITION_5];
    
    mHandCards =  [NSMutableArray arrayWithArray:[mManagedObjectFactory entitiesNamed:sGameCardEntity withPredicate:[NSPredicate predicateWithFormat:predicateString] sortedOn:nil ascending:YES]];
    [mHandCards retain];

    predicateString = [NSString stringWithFormat:@"discarded == 0 && player == %i  && (handPosition == %i)", mPlayer, CARD_IN_PLAY_POSITION];
    cards = [NSMutableArray arrayWithArray:[mManagedObjectFactory entitiesNamed:sGameCardEntity withPredicate:[NSPredicate predicateWithFormat:predicateString] sortedOn:nil ascending:YES]];
    
    if ([cards count] > 0) {
        self.playCard = [cards objectAtIndex:0];
        mPlayedFirstCard = YES;
    }
}


-(BOOL)__loadCardsIntoDeck
{
    BOOL newCards = NO;
    
    if ([mGame.turnCount intValue] <= 0) {
        NSString* predicateString;
    
        // Exhibit Cards
        predicateString = [NSString stringWithFormat:@"player == %i && immutableCard.unlocked == 1 && (immutableCard.type == %i || immutableCard.type == %i || immutableCard.type == %i)", mPlayer, CARD_TYPE_EXHIBIT, CARD_TYPE_SPECIAL_EXHIBIT, CARD_TYPE_EASTER_EGG];
        //predicateString = [NSString stringWithFormat:@"player == %i && immutableCard.unlocked == 1 && immutableCard.name == 'Peregrine Falcon' && (immutableCard.type == %i || immutableCard.type == %i || immutableCard.type == %i)", mPlayer, CARD_TYPE_EXHIBIT, CARD_TYPE_SPECIAL_EXHIBIT, CARD_TYPE_EASTER_EGG];
        [self __loadCardsIntoDeckWithPredicateString:predicateString andNumberOfCards:EXHIBIT_CARDS_IN_DECK_MAX];
        // Booster Cards
        predicateString = [NSString stringWithFormat:@"player == %i && immutableCard.unlocked == 1 && (immutableCard.type == %i || immutableCard.type == %i || immutableCard.type == %i || immutableCard.type == %i)", 
                           mPlayer, CARD_TYPE_BOOSTER_ANTHROPOLOGY, CARD_TYPE_BOOSTER_BOTANY, CARD_TYPE_BOOSTER_GEOLOGY, CARD_TYPE_BOOSTER_ZOOLOGY];
        [self __loadCardsIntoDeckWithPredicateString:predicateString andNumberOfCards:SUPER_CARDS_IN_DECK_MAX];
        // Gotcha Cards
    //    predicateString = [NSString stringWithFormat:@"player == %i && immutableCard.unlocked == 1 && (immutableCard.type == %i)",  
  //                         mPlayer, CARD_TYPE_GOTCHA_SKIP_TURN];
        predicateString = [NSString stringWithFormat:@"player == %i && immutableCard.unlocked == 1 && (immutableCard.type >= %i && immutableCard.type <= %i)",  
                           mPlayer, CARD_TYPE_GOTCHA_ADD_10_POINTS_TO_MY_CARD, CARD_TYPE_GOTCHA_SKIP_TURN];
        [self __loadCardsIntoDeckWithPredicateString:predicateString andNumberOfCards:GOTCHA_CARDS_IN_DECK_MAX];
        [self __pullCharacterCardsToTopOfDeck];
        newCards = YES;
    }
    
    return newCards;
}


-(void)__loadCardsIntoDeckWithPredicateString:(NSString*)predicateString andNumberOfCards:(int)numberOfCards
{
    NSMutableArray* gameCards = [NSMutableArray arrayWithArray:[mManagedObjectFactory entitiesNamed:sGameCardEntity 
                                                                                                      withPredicate:[NSPredicate predicateWithFormat:predicateString] 
                                                                                                           sortedOn:nil 
                                                                                                          ascending:YES
                                                                                                              limit:numberOfCards]];    
    for (GameCard* gameCard in gameCards) {
        if ([gameCard.immutableCard.boostedPower intValue] > 0 && mPlayer == PLAYER_ONE) {
            gameCard.power = gameCard.immutableCard.boostedPower;
        }
        else{
            gameCard.power = ([gameCard.boostedBasePower intValue] == 0) ? gameCard.immutableCard.power : gameCard.boostedBasePower;
        }
        
        gameCard.handPosition = 0;
        gameCard.discarded = [NSNumber numberWithBool:NO];
        gameCard.hasSwitchBoost = [NSNumber numberWithBool:NO];
        gameCard.retreatBoostApplied = [NSNumber numberWithBool:NO];
        
        gameCard.hasPrimaryActionType = ([gameCard.immutableCard.primaryAction.actionType intValue] == CARD_TYPE_BOOSTER_FREE) ? 
        [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
        
        gameCard.hasSecondaryActionTypeA = ([gameCard.immutableCard.secondaryAction.actionTypeA intValue] == CARD_TYPE_BOOSTER_FREE) ? 
        [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
        
        gameCard.hasSecondaryActionTypeB = ([gameCard.immutableCard.secondaryAction.actionTypeB intValue] == CARD_TYPE_BOOSTER_FREE) ? 
        [NSNumber numberWithBool:YES] : [NSNumber numberWithBool:NO];
        
        gameCard.player = [NSNumber numberWithInt:mPlayer];  
        gameCard.game = mGame;
    }
    
    [mManagedObjectFactory commit];
    
    [gameCards shuffle];
    [mDeck addObjectsFromArray:gameCards];    
    [mDeck shuffle];
}


-(void)__pullCharacterCardsToTopOfDeck
{
    GameCard* firstCharacterGameCard = nil;
    GameCard* secondCharacterGameCard = nil;
    //GameCard* minusTenGotchaGameCard = nil;
    //GameCard* freeSwitchGameCard = nil;
    
    for(GameCard* gameCard in mDeck)
    {
        if([gameCard.immutableCard.type intValue] == CARD_TYPE_EXHIBIT || 
           //[gameCard.immutableCard.type intValue] == CARD_TYPE_GOTCHA_ADD_10_POINTS_TO_MY_CARD || 
           //[gameCard.immutableCard.type intValue] == CARD_TYPE_GOTCHA_FREE_SWITCH || 
           [gameCard.immutableCard.type intValue] == CARD_TYPE_SPECIAL_EXHIBIT || 
           [gameCard.immutableCard.type intValue] == CARD_TYPE_EASTER_EGG)
        {
            if(firstCharacterGameCard == nil)
            {
                firstCharacterGameCard = gameCard;
            }
            else if(secondCharacterGameCard == nil)
            {
                secondCharacterGameCard = gameCard;
            //}
            //else if((minusTenGotchaGameCard == nil) && 
            //        ([gameCard.immutableCard.type intValue] == CARD_TYPE_GOTCHA_ADD_10_POINTS_TO_MY_CARD))
            //{
            //    minusTenGotchaGameCard = gameCard;
            //}
            //else if((freeSwitchGameCard == nil) && 
            //        ([gameCard.immutableCard.type intValue] == CARD_TYPE_GOTCHA_FREE_SWITCH))
            //{
            //    freeSwitchGameCard = gameCard;
                break;
            }
        }
    }
    
    [mDeck removeObject:firstCharacterGameCard];
    [mDeck removeObject:secondCharacterGameCard];
    //[mDeck removeObject:minusTenGotchaGameCard];
    //[mDeck removeObject:freeSwitchGameCard];
    
    [mDeck insertObject:firstCharacterGameCard atIndex:0];
    [mDeck insertObject:secondCharacterGameCard atIndex:5];
    //[mDeck insertObject:minusTenGotchaGameCard atIndex:2];
    //[mDeck insertObject:freeSwitchGameCard atIndex:3];
}




@end
