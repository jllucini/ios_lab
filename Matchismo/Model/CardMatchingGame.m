//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 07/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) ScoreHelper *scoreHelper;
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(ScoreHelper *)scoreHelper
{
    if (!_scoreHelper) _scoreHelper = [[ScoreHelper alloc] init];
    return _scoreHelper;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self){
        for (int i = 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
            
        }
    }
    
    return self;
}

-(id)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MATCH_BONUS = 4;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    // Auxiliar variables
    int MISMATCH_PENALTY = self.gameMode;
    NSMutableString *matchMessage = [NSMutableString stringWithString:@""];
    NSMutableArray *otherCards = [NSMutableArray array];
    int matchScore = 0;
    int totalScore = self.scoreHelper.totalScore;
    // Match Algorithm
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (card.isChosen){
            // Deselects current card
            card.chosen = NO;
        } else {
            // match against other chosen card
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            if ([otherCards count] +1 == self.gameMode) {
                matchScore = [card match:otherCards];
                [matchMessage appendFormat:@"%@", [card explainMatch:otherCards]];
                if (matchScore) {
                    matchScore = matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                    }
                    [matchMessage appendFormat:@" for %d point!", matchScore ];
                } else {
                    matchScore = -MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                    }
                    [matchMessage appendFormat:@" %d point penalty!", MISMATCH_PENALTY];
                }

            }
            // Not needed in this assignment
            card.chosen = YES;
        }
    }
    // Update Score Helper status
    totalScore += matchScore;
    [otherCards addObject:card];
    [self.scoreHelper setData:totalScore lastScore:matchScore descr:matchMessage cards:otherCards];
}


-(NSArray *)moreCards:(NSUInteger)numCards usingDeck:(Deck *)deck;
{
    NSMutableArray *result = nil;
    for (int i = 0; i < numCards; i++){
        Card *card = [deck drawRandomCard];
        if (card){
            [self.cards addObject:card];
            if (!result){
                result = [[NSMutableArray alloc]init];
            }
            [result addObject:card];
        } else {
            break;
        }
        
    }
    return result;
}

-(NSUInteger)numberOfCards
{
    return [self.cards count];
}

-(void)removeCardsAtIndex:(NSIndexSet *)index
{
    [self.cards removeObjectsAtIndexes:index];
}

@end
