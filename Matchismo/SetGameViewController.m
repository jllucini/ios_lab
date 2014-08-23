//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 10/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation SetGameViewController

// Subclassing AbstractGameViewController

- (IBAction)touchCardButton:(UIButton *)sender
{
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self recordHistory];
    [self updateUI:NO];
}

-(void)recordHistory
{
    if (self.game.scoreHelper.lastScore != 0) {
        for (SetCard *card in self.game.scoreHelper.cards){
            [self.scoreHistory appendFormat:@"%@", card.contents];
        }
        [self.scoreHistory appendFormat:@"\nScore:%d Total Score: %d\n", self.game.scoreHelper.lastScore, self.game.scoreHelper.totalScore];
    }
}

-(IBAction)resetUI:(UIButton *)sender
{
    self.scoreLabel.text = @"Score Set: 0";
    self.msgArea.text = @"";
    self.game = nil;
    [self.scoreHistory deleteCharactersInRange:NSMakeRange(0, [self.scoreHistory length])];
    [self updateUI:YES];
}

-(Deck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

-(NSUInteger)gameMode
{
    return 3;
}

-(void)updateUI:(BOOL)firstTime
{
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        SetCard *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAlpha: [card isChosen] && !card.isMatched ? 0.8 : 1.0];
        if ([card isChosen] || firstTime)
        {
            NSMutableAttributedString *nsmas = [self formatButton:card];
            [cardButton setAttributedTitle:nsmas forState:UIControlStateNormal];
        }
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score Set: %d", self.game.scoreHelper.totalScore];
        self.msgArea.text = self.game.scoreHelper.descr;
    }
}

// Instance methods
-(NSMutableAttributedString *)formatButton:(SetCard *)card
{
    NSMutableString *fillString = [NSMutableString stringWithString:card.shape];
    
    if ([card.number intValue] > 1){
        [fillString appendString:card.shape];
    }
    if ([card.number intValue] > 2){
        [fillString appendString:card.shape];
    }
    
    NSMutableAttributedString *nsmas = [[NSMutableAttributedString alloc] initWithString:fillString];
    CIColor *cicolor = [CIColor colorWithString:card.color];
    UIColor *uicolor = [UIColor colorWithCIColor:cicolor];
    [nsmas setAttributes:@{NSForegroundColorAttributeName : uicolor,
                           NSFontAttributeName: [UIFont preferredFontForTextStyle:UIFontTextStyleBody]}
                   range:NSMakeRange(0, [fillString length] )] ;
    
    if ([card.shading isEqualToString:@"open"]){
        [nsmas setAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                NSStrokeWidthAttributeName:@-5,
                                NSStrokeColorAttributeName:uicolor,
                                }
                       range:NSMakeRange(0, [fillString length])];
    }
    
    if ([card.shading isEqualToString:@"striped"]){
        [nsmas setAttributes: @{NSForegroundColorAttributeName : [UIColor whiteColor],
                                NSStrokeWidthAttributeName:@-5,
                                NSStrokeColorAttributeName:uicolor,
                                NSStrikethroughColorAttributeName: uicolor,
                                NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle) }
                       range:NSMakeRange(0, [fillString length])];
    }
    
    return nsmas;
}

@end
