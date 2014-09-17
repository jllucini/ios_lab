//
//  DiamondsView.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 05/09/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "DiamondsView.h"

@interface DiamondsView ()

@property (strong, nonatomic) UIColor *uicolor;
@property (strong, nonatomic) SetCard *setCard;

@end

@implementation DiamondsView

/* PUBLIC INTERFACE
 ----------------
 */

-(id)initWithBounds:(CGRect)bounds
{
    self = [super initWithFrame:bounds];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

-(void)drawDiamondsWithCard:(SetCard *)setCard
{
    CIColor *cicolor = [CIColor colorWithString:setCard.color];
    UIColor *auicolor = [UIColor colorWithCIColor:cicolor];
    
    self.setCard = setCard;
    self.uicolor= auicolor;
    
    if (setCard.number.intValue == 1){
        int xsize = self.bounds.size.width / 1.5;
        int ysize = xsize / 2.5;
        int xorigin = 0;
        int yorigin = 0;
        
        self.bounds = CGRectMake(xorigin, yorigin, xsize, ysize);
    }
    if (setCard.number.intValue == 2){
        int xsize = self.bounds.size.width / 1.5;
        int ysize = (xsize / 2.5)*2.0 ;
        int xorigin = 0;
        int yorigin = 0;
        self.bounds = CGRectMake(xorigin, yorigin, xsize, ysize);
    }
    if (setCard.number.intValue == 3){
        int xsize = self.bounds.size.width / 1.5;
        int ysize = (xsize / 2.5)*3.0;
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
        int ysize = xsize/2.5;
        int halfx = xsize/2.0;
        int halfy = ysize/2.0;
        int xorigin = self.bounds.origin.x;
        int yorigin = self.bounds.origin.y;
        for (int ix = 0; ix < iNumber; ix++){
            yorigin = ix*ysize+halfy;
            UIBezierPath *figRect = [UIBezierPath bezierPath];
            CGPoint c = CGPointMake(xsize/2.0, yorigin);
            [figRect moveToPoint:CGPointMake(c.x-halfx, c.y)];
            [figRect addLineToPoint:CGPointMake(c.x, c.y-halfy*0.8)];
            [figRect addLineToPoint:CGPointMake(c.x+halfx, c.y)];
            [figRect addLineToPoint:CGPointMake(c.x, c.y+halfy*0.8)];
            [figRect closePath];
            
            if ([self.setCard.shading isEqual: @SHADING_SOLID]) {
                [self.uicolor setFill];
            } else {
                [[UIColor whiteColor] setFill];
            }
            
            [self.uicolor setStroke];
            [figRect fill];
            [figRect stroke];
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            [figRect addClip];
            
            if ([self.setCard.shading isEqual: @SHADING_STRIPED]) {
                int nLines = 15;
                float fLines = 15.0;
                for (int ix = 1; ix < nLines; ix++){
                    UIBezierPath *line = [[UIBezierPath alloc] init] ;
                    [line moveToPoint:CGPointMake(xorigin+(xsize/fLines)*ix, yorigin-halfy)];
                    [line addLineToPoint:CGPointMake(xorigin+(xsize/fLines)*ix, yorigin+halfy)];
                    [line closePath];
                    [self.uicolor setStroke];
                    [line stroke];
                }
            }
            CGContextRestoreGState(context);
        }
    }
}


#pragma mark - Initialization

- (void)setup
{
    self.backgroundColor = [UIColor yellowColor];//nil;
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
