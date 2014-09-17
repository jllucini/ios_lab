//
//  SquigglesView.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 06/09/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "SquigglesView.h"

@interface SquigglesView ()

@property (strong, nonatomic) UIColor *uicolor;
@property (strong, nonatomic) SetCard *setCard;

@end

@implementation SquigglesView

/* PUBLIC INTERFACE
   ----------------
 */

-(id)initWithBounds:(CGRect)bounds
{
    self = [super initWithFrame:bounds];
    self.backgroundColor = [UIColor whiteColor];
    return self;
}

-(void)drawSquigglesWithCard:(SetCard *)setCard
{
    CIColor *cicolor = [CIColor colorWithString:setCard.color];
    UIColor *auicolor = [UIColor colorWithCIColor:cicolor];
    
    self.setCard = setCard;
    self.uicolor= auicolor;
    
    if (setCard.number.intValue == 1){
        int xsize = self.bounds.size.width / 1.5;
        int ysize = xsize / 3.0;
        int xorigin = 0;
        int yorigin = 0;
        
        self.bounds = CGRectMake(xorigin, yorigin, xsize, ysize);
    }
    if (setCard.number.intValue == 2){
        int xsize = self.bounds.size.width / 1.5;
        int ysize = (xsize / 3.0)*2.0;
        int xorigin = 0;
        int yorigin = 0;
        self.bounds = CGRectMake(xorigin, yorigin, xsize, ysize);
    }
    if (setCard.number.intValue == 3){
        int xsize = self.bounds.size.width / 1.5;
        int ysize = (xsize / 3.0)*3.0;
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
    // Drawing code
    if (self.setCard){
        int iNumber = self.setCard.number.intValue;
        int xsize = self.bounds.size.width*0.8;
        int ysize = self.bounds.size.height/iNumber;
        int xorigin = self.bounds.origin.x+self.bounds.size.width*0.1;
        int yorigin = self.bounds.origin.y;
        for (int ix = 0; ix < iNumber; ix++){
            yorigin = ix*ysize;
            
            CGPoint leftCircleCenter = CGPointMake(xorigin+ysize*0.5, yorigin+ysize*0.5);
            CGFloat largeRadius = ysize*0.4;
            CGFloat smallRadius = ysize*0.4;
            CGFloat leftDownAngle = M_PI*0.5;
            CGFloat leftUpAngle = M_PI * (3.0/ 2.0);
            CGPoint upperRightCorner= CGPointMake(xorigin+xsize-ysize*0.5, yorigin+ysize*0.1);
            CGPoint downLeftCorner= CGPointMake(xorigin+ysize*0.5, yorigin+ysize*0.9);
            CGPoint ctrPointUp1 = CGPointMake(xorigin+ysize*0.5, yorigin+ysize*0.1);
            CGPoint ctrPointUp2 = CGPointMake(xorigin+xsize-(ysize*0.5), yorigin+ysize*0.6);
            CGPoint ctrPointUp3 = CGPointMake(xorigin+xsize-(ysize*0.5), yorigin+ysize*0.9);
            CGPoint ctrPointUp4 = CGPointMake(xorigin+(ysize*0.5), yorigin+ysize*0.4);
            CGPoint rightCircleCenter = CGPointMake(xorigin+xsize-(ysize*0.5), yorigin+ysize*0.5);
            CGFloat rightUpAngle = M_PI * (3.0/ 2.0);
            CGFloat rightDownAngle = M_PI*0.5;
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path addArcWithCenter:leftCircleCenter
                            radius:smallRadius
                        startAngle:leftDownAngle
                          endAngle:leftUpAngle
                         clockwise:YES];
            [path addCurveToPoint:upperRightCorner controlPoint1:ctrPointUp1 controlPoint2:ctrPointUp2];
            [path addArcWithCenter:rightCircleCenter
                            radius:largeRadius
                        startAngle:rightUpAngle
                          endAngle:rightDownAngle
                         clockwise:YES];
            [path addCurveToPoint:downLeftCorner controlPoint1:ctrPointUp3 controlPoint2:ctrPointUp4];
            [path closePath];
            
            if ([self.setCard.shading isEqual: @SHADING_SOLID]) {
                [self.uicolor setFill];
            } else {
                [[UIColor whiteColor] setFill];
            }
            
            [self.uicolor setStroke];
            [path fill];
            [path stroke];
            
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSaveGState(context);
            [path addClip];
            
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
            CGContextRestoreGState(context);
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
