//
//  SetCardView.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 31/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "SetCardView.h"
#import "OvalsView.h"
#import "DiamondsView.h"
#import "SquigglesView.h"

@interface SetCardView ()

@property (strong, nonatomic)  SetCard* setCard;

@end

@implementation SetCardView

/* PUBLIC FUNCTIONS
   ----------------
 */

- (void)setupViewWithCard:(SetCard *) setCard
{
    for(UIView *subview in [self subviews]) {
        [subview removeFromSuperview];
    }
    self.setCard = setCard;
    [self setNeedsDisplay];
}


/* HELPER FUNCTIONS 
   ----------------
 */


/* UIView FUNCTIONS
   ----------------
 */

#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

- (CGFloat)cornerScaleFactor {
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat)cornerRadius {
    return CORNER_RADIUS * [self cornerScaleFactor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing the card rectangle
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    // Drawing the card content
    if (self.setCard){
        switch ([self.setCard.shape intValue]) {
            case SHAPE_OVAL:
            {
                OvalsView *ovalView = [[OvalsView alloc] initWithBounds:self.bounds];
                [ovalView drawOvalsWithCard:self.setCard];
                [self addSubview:ovalView] ;
                break;
            }
            case SHAPE_DIAMOND:
            {
                DiamondsView *diamondView = [[DiamondsView alloc] initWithBounds:self.bounds];
                [diamondView drawDiamondsWithCard:self.setCard];
                [self addSubview:diamondView] ;
                break;
            }
            case SHAPE_SQUIGGLE:
            {
                SquigglesView *squigglesView = [[SquigglesView alloc] initWithBounds:self.bounds];
                [squigglesView drawSquigglesWithCard:self.setCard];
                [self addSubview:squigglesView] ;
                break;
            }
            default:
                break;
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
