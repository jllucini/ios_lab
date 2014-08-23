//
//  AbstractGameViewController.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 11/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "AbstractGameViewController.h"

@interface AbstractGameViewController ()
@end

@implementation AbstractGameViewController

-(void)viewWillLayoutSubviews
{
    [self updateUI:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HistoryViewController *hvc = (HistoryViewController *)segue.destinationViewController;
    [hvc setHistory: self.scoreHistory];
}

-(void)setHistory:(NSString *)record
{
    [self.scoreHistory appendString:record];
}

- (NSMutableString *)scoreHistory
{
    if (!_scoreHistory){
        _scoreHistory = [[NSMutableString alloc]initWithString:@""];
    }
    return _scoreHistory;
}

-(CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
        _game.gameMode = [self gameMode];
    }
    return _game;
}

-(Deck *)createDeck
{
    return nil;
}

-(void)updateUI:(BOOL)firstTime
{
    
}

-(NSUInteger)gameMode
{
    return 0;
}

@end
