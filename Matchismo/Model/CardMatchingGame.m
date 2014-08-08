//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 07/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSString *scoreDescr;
@property (nonatomic, strong) NSMutableArray *cards; // of Cards
@end

@implementation CardMatchingGame

- (NSString *)scoreDescr
{
    return _scoreDescr ? _scoreDescr : @"";
}

-(NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
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

-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index
{
    int MISMATCH_PENALTY = self.gameMode;
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched){
        if (card.isChosen){
            card.chosen = NO;
        } else {
            // match against other chosen card
            NSMutableArray *otherCards = [NSMutableArray array];
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [otherCards addObject:otherCard];
                }
            }
            NSMutableString *matchMessage = [NSMutableString stringWithString:@""];
            if ([otherCards count] +1 == self.gameMode) {
                int matchScore = [card match:otherCards];
                //NSLog(@"Match Score: %d",matchScore);
                if (matchScore) {
                    [matchMessage appendFormat:@"Matched %@", card.contents];
                    self.score += matchScore * MATCH_BONUS;
                    card.matched = YES;
                    for (Card *otherCard in otherCards) {
                        otherCard.matched = YES;
                        [matchMessage appendFormat:@" %@", otherCard.contents];
                    }
                    [matchMessage appendFormat:@" for %d point.", matchScore * MATCH_BONUS];
                } else {
                    [matchMessage appendFormat:@"%@", card.contents];
                    self.score -= MISMATCH_PENALTY;
                    for (Card *otherCard in otherCards) {
                        otherCard.chosen = NO;
                        [matchMessage appendFormat:@" %@", otherCard.contents];
                    }
                    [matchMessage appendFormat:@" don't match! %d point penalty!", MISMATCH_PENALTY];
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            self.scoreDescr = matchMessage;
        }
    }
}


@end
