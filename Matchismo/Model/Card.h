//
//  Card.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 06/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;
-(NSString *)explainMatch:(NSArray *)otherCards;

@end
