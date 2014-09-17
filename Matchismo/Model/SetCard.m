//
//  SetCard.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 10/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "SetCard.h"

@interface SetCard()
@property (strong, nonatomic) NSMutableString *matchMessage;
@end

@implementation SetCard

- (NSString *)contents
{
    return [NSMutableString stringWithFormat:@"[%@%@ %@ %@]",
            self.number, self.shape, self.shading, [self colorToString:self.color]];
}

+(BOOL)match:(SetCard *)card withCards:(NSArray *)otherCards forFeatureBlock:(id(^)(SetCard *acard))featureBlock msg:(NSString *)selector
{
    BOOL match = YES;
    
    id cardFeatureValue  = featureBlock(card) ;
    id card2FeatureValue = featureBlock(otherCards[0]);
    id card3FeatureValue = featureBlock(otherCards[1]);
    
    if ([cardFeatureValue isKindOfClass:[NSString class] ])
    {
        match = ( ([cardFeatureValue isEqualToString:card2FeatureValue] &&
                   [cardFeatureValue isEqualToString:card3FeatureValue] &&
                   [card2FeatureValue isEqualToString:card3FeatureValue] ) ||
                 (![cardFeatureValue isEqualToString:card2FeatureValue] &&
                  ![cardFeatureValue isEqualToString:card3FeatureValue] &&
                  ![card2FeatureValue isEqualToString:card3FeatureValue] ) );
    }
    else if ([cardFeatureValue isKindOfClass:[NSNumber class] ])
    {
        match = ( (cardFeatureValue == card2FeatureValue &&
                   cardFeatureValue == card3FeatureValue &&
                   card2FeatureValue==card3FeatureValue ) ||
                 (cardFeatureValue != card2FeatureValue &&
                  cardFeatureValue != card3FeatureValue &&
                  card2FeatureValue != card3FeatureValue ) );
    }
    
    if (!match) [card.matchMessage appendFormat:@"%@", selector];
    return match;
}

-(int)match:(NSArray *)otherCards
{
    int score = 0; // No match
    self.matchMessage = [NSMutableString stringWithString:@""];
    typedef NSNumber* (^shapeBlock_t) (SetCard *card);
    shapeBlock_t shapeSelector = ^(SetCard * aCard) {
        return [aCard shape];
    };
    typedef NSNumber* (^numberBlock_t) (SetCard *card);
    numberBlock_t numberSelector = ^(SetCard * aCard) {
        return [aCard number];
    };
    typedef NSNumber* (^shadingBlock_t) (SetCard *card);
    shadingBlock_t shadingSelector = ^(SetCard * aCard) {
        return [aCard shading];
    };
    typedef NSString* (^colorBlock_t) (SetCard *card);
    colorBlock_t colorSelector = ^(SetCard * aCard) {
        return [aCard color];
    };
    
    if ([SetCard match:self withCards:otherCards forFeatureBlock:shapeSelector msg:@"shape"] &&
        [SetCard match:self withCards:otherCards forFeatureBlock:numberSelector msg:@"number"] &&
        [SetCard match:self withCards:otherCards forFeatureBlock:colorSelector msg:@"color"] &&
        [SetCard match:self withCards:otherCards forFeatureBlock:shadingSelector msg:@"shading"])
    {
        score = 1;
    }
    
    return score;
}

-(NSString *)explainMatch:(NSArray *)otherCards
{
    if ([self.matchMessage length] > 0)
    {
        self.matchMessage = [NSMutableString stringWithFormat: @"Invalid %@,", self.matchMessage];
    } else {
        self.matchMessage = [NSMutableString stringWithString: @"Cards match,"];
    }
    return self.matchMessage;
}
            
-(NSString *)colorToString:(NSString *)colorRGB
{
    if ([colorRGB isEqualToString:@"1.0 0.0 0.0 1.0"]) return @"r";
    if ([colorRGB isEqualToString:@"0.0 0.5 0.0 1.0"]) return @"g";
    return @"p";
}

+(NSArray *)validShapes
{
    return @[@SHAPE_DIAMOND, @SHAPE_OVAL, @SHAPE_SQUIGGLE];
}

+(NSArray *)validNumbers
{
    return @[@1, @2, @3];
}

+(NSDictionary *)validColors
{
    return @{@"red":@"1.0 0.0 0.0 1.0", @"green":@"0.0 0.5 0.0 1.0", @"purple":@"0.5 0.0 0.5 1.0"};
}

+(NSArray *)validShadings
{
    return @[@SHADING_SOLID, @SHADING_STRIPED, @SHADING_OPEN];
}

@end
