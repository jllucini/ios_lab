//
//  Card.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 06/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "Card.h"

@implementation Card

-(int)match:(NSArray *)otherCards
{
    int score=0;
    for (Card *card in otherCards){
        if ([card.contents isEqualToString:self.contents]) {
            score=1;
        }
    }
    return score;
}

-(NSString *)explainMatch:(NSArray *)otherCards
{
    return ([self match:otherCards]) ? @"Cards match !": @"Cards do not match !";
}
@end
