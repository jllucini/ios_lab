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

+(BOOL)match:(SetCard *)card withCards:(NSArray *)otherCards forFeature:(SEL)featureSelector
{
    BOOL match = YES;

    id cardFeatureValue = [card performSelector:featureSelector];
    //NSLog(@".... Match %@ %@", card.contents, cardFeatureValue);
    id card2FeatureValue = [otherCards[0] performSelector:featureSelector];
    id card3FeatureValue = [otherCards[1] performSelector:featureSelector];
    
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
    
    //NSLog(@"Match -> %d", match);
    if (!match) [card.matchMessage appendFormat:@"%@", NSStringFromSelector(featureSelector)];
    return match;
}

-(int)match:(NSArray *)otherCards
{
    int score = 0; // No match
    self.matchMessage = [NSMutableString stringWithString:@""];
    SEL shapeSelector = @selector(shape);
    SEL numberSelector = @selector(number);
    SEL colorSelector = @selector(color);
    SEL shadingSelector = @selector(shading);
    
    if ([SetCard match:self withCards:otherCards forFeature:shapeSelector] &&
        [SetCard match:self withCards:otherCards forFeature:numberSelector] &&
        [SetCard match:self withCards:otherCards forFeature:colorSelector] &&
        [SetCard match:self withCards:otherCards forFeature:shadingSelector])
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
    return @[@"■", @"▲", @"✹"];
}

+(NSArray *)validNumbers
{
    return @[@1, @2, @3];
}

+(NSDictionary *)validColors
{
    return @{@"red":@"1.0 0.0 0.0 1.0", @"green":@"0.0 0.5 0.0 1.0", @"purple":@"0.5 0.0 0.5 1.0"};
}

+(NSDictionary *)validShadings
{
    return @{@"solid":@"solid", @"striped":@"striped", @"open":@"open"};
}

@end
