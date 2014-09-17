//
//  DiamondsView.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 05/09/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface DiamondsView : UIView

-(id)initWithBounds:(CGRect)bounds;
-(void)drawDiamondsWithCard:(SetCard *)setCard;

@end
