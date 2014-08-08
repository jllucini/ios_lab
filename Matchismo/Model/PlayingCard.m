//
//  PlayingCard.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 06/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int)match:(NSArray *)otherCards
{
    int score = 0;
    NSMutableArray *auxCards = [[NSMutableArray alloc] initWithArray:otherCards];
    [auxCards insertObject:self atIndex:0];
    int nCards = [auxCards count];
    
    for (int sourceCardIx = 0; sourceCardIx < nCards ; sourceCardIx++){
        PlayingCard *sourceCard = auxCards[sourceCardIx];
        for (int cardToCompareIx = sourceCardIx + 1; cardToCompareIx < nCards ; cardToCompareIx++){
            PlayingCard *cardToCompare = auxCards[cardToCompareIx];
            if (sourceCard.rank == cardToCompare.rank){
                score += 4;
            } else if ([sourceCard.suit isEqualToString:cardToCompare.suit]){
                score += 1;
            }
        }
    }
    
    return score;
}

- (NSString *)contents
{
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit=_suit;
+ (NSArray *)validSuits
{
    return @[@"♣", @"♠", @"♦", @"♥"];}
- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }
}
- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1 ;
}

- (void) setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank])
    {
        _rank = rank;
    }
}

@end
