//
//  SetCard.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 10/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSNumber *shape;
@property (nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *color;
@property (strong, nonatomic) NSNumber *shading;

#define SHAPE_OVAL 1
#define SHAPE_DIAMOND 2
#define SHAPE_SQUIGGLE 3
#define SHADING_SOLID 1
#define SHADING_STRIPED 2
#define SHADING_OPEN 3


+(NSArray *)validShapes;
+(NSArray *)validNumbers;
+(NSDictionary *)validColors;
+(NSArray *)validShadings;

@end
