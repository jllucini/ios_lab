//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 07/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic,readonly) NSInteger score;
@property (nonatomic) NSUInteger gameMode;
@property (nonatomic, readonly) NSString *scoreDescr;

@end
