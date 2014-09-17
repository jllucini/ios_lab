//
//  SquigglesView.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 06/09/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface SquigglesView : UIView

-(id)initWithBounds:(CGRect)bounds;
-(void)drawSquigglesWithCard:(SetCard *)setCard;

@end
