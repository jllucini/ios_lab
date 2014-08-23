//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 10/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "SetCardDeck.h"

@implementation SetCardDeck

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        for (NSNumber *number in [SetCard validNumbers])
        {
            for (NSString *shape in [SetCard validShapes])
            {
                for (NSString *shading in [SetCard validShadings])
                {
                    for (NSString *color in [SetCard validColors]   )
                    {
                        SetCard *card = [[SetCard alloc] init];
                        card.number = number;
                        card.shape = shape;
                        card.shading = shading;
                        card.color = [SetCard validColors][color];
                        [self addCard:card];
                    }
                }
            }
        }
    }
    
    return self;
}

@end
