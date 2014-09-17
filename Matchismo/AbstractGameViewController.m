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

-(CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:self.numCards
                                                  usingDeck:self.deck];
        _game.gameMode = [self gameMode];
    }
    return _game;
}

-(Deck *)deck
{
    if (!_deck){
        _deck = [self createDeck];
    }
    return _deck;
}


// Abstract methods
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
