//
//  DiamondView.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 31/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "OvalsView.h"

@interface OvalsView ()

@property (strong, nonatomic) UIColor *uicolor;
@property (strong, nonatomic) SetCard *setCard;

@end

@implementation OvalsView

/* PUBLIC INTERFACE
   ----------------
 */

-(id)initWithBounds:(CGRect)bounds
{
    self = [super initWithFrame:bounds];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

-(void)drawOvalsWithCard:(SetCard *)setCard
{
    CIColor *cicolor = [CIColor colorWithString:setCard.color];
    UIColor *auicolor = [UIColor colorWithCIColor:cicolor];
    
    self.setCard = setCard;
    self.uicolor= auicolor;
    
    if (setCard.number.intValue == 1){
        int xsize = self.bounds.size.width / 1.5;
        int ysize = xsize / 4.0;
        int xorigin = 0;
        int yorigin = 0;
        
        self.bounds = CGRectMake(xorigin, yorigin, xsize, ysize);
    }
    if (setCard.number.intValue == 2){
        int xsize = self.bounds.size.width / 1.5;
        int ysize = (xsize / 4.0)*3.0;
        int xorigin = 0;
        int yorigin = 0;
        self.bounds = CGRectMake(xorigin, yorigin, xsize, ysize);
    }
    if (setCard.number.intValue == 3){
        int xsize = self.bounds.size.width / 1.5;
        int ysize = (xsize / 4.0)*5.0;
        int xorigin = 0;
        int yorigin = 0;
        
        self.bounds = CGRectMake(xorigin, yorigin, xsize, ysize);
    }
    [self setNeedsDisplay];
}

/* DEFAULT FUNCTIONS
   -----------------
 */

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (self.setCard){
        int iNumber = self.setCard.number.intValue;
        int xsize = self.bounds.size.width;
        int ysize = self.bounds.size.height;
        if (iNumber == 2) ysize = ysize / 3.0;
        if (iNumber == 3) ysize = ysize / 5.0;

        int maxLoops = 1;
        if (iNumber == 2) maxLoops = 3;
        if (iNumber == 3) maxLoops = 5;
        for (int ix = 0; ix < maxLoops; ix++){
            int xorigin = self.bounds.origin.x;
            int yorigin = self.bounds.origin.y+(ysize*ix);
            if (ix % 2 == 0){
                UIBezierPath *figRect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(xorigin, yorigin, xsize, ysize) cornerRadius:xsize / 2.0 ];
                [figRect closePath];
                
                if ([self.setCard.shading isEqual: @SHADING_SOLID]) {
                    [self.uicolor setFill];
                } else {
                    [[UIColor whiteColor] setFill];
                }
                
                [self.uicolor setStroke];
                [figRect fill];
                [figRect setLineWidth:2.0];
                [figRect stroke];
                [figRect setLineWidth:1.0];
                
                if ([self.setCard.shading isEqual: @SHADING_STRIPED]) {
                    int nLines = 15;
                    float fLines = 15.0;
                    for (int ix = 1; ix < nLines; ix++){
                        UIBezierPath *line = [[UIBezierPath alloc] init] ;
                        [line moveToPoint:CGPointMake(xorigin+(xsize/fLines)*ix, yorigin)];
                        [line addLineToPoint:CGPointMake(xorigin+(xsize/fLines)*ix, yorigin+ysize)];
                        [line closePath];
                        [self.uicolor setStroke];
                        [line stroke];
                    }
                }
            }
        }
    }
}



#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

@end
