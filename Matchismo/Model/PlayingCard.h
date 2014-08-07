//
//  PlayingCard.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 06/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;

@end
