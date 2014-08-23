//
//  ScoreHelper.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 17/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "ScoreHelper.h"

@implementation ScoreHelper

- (NSMutableArray *) cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSString *)descr
{
    return _descr ? _descr : @"";
}

-(void)setData:(NSInteger)totalScore lastScore:(NSInteger)lastScore descr:(NSString *)descr cards:(NSMutableArray *)cards
{
    self.totalScore = totalScore;
    self.lastScore  = lastScore;
    self.descr      = descr;
    self.cards      = cards;
}
@end
