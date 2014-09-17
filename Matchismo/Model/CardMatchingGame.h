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
#import "ScoreHelper.h"

@interface CardMatchingGame : NSObject

// designated initializer
-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck;

-(void)chooseCardAtIndex:(NSUInteger)index;
-(id)cardAtIndex:(NSUInteger)index;
-(NSArray *)moreCards:(NSUInteger )numCards usingDeck:(Deck *)deck;
-(NSUInteger)numberOfCards;
-(void)removeCardsAtIndex:(NSIndexSet *)index;

@property (nonatomic) NSUInteger gameMode;
@property (nonatomic, readonly) NSString *scoreDescr;
@property (nonatomic, readonly) ScoreHelper *scoreHelper;

@end
