//
//  DiamondView.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 31/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface OvalsView : UIView

-(id)initWithBounds:(CGRect)bounds;
-(void)drawOvalsWithCard:(SetCard *)setCard;

@end
