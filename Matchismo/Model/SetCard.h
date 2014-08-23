//
//  SetCard.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 10/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *shape;
@property (nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSString *shading;

+(NSArray *)validShapes;
+(NSArray *)validNumbers;
+(NSDictionary *)validColors;
+(NSDictionary *)validShadings;

@end
