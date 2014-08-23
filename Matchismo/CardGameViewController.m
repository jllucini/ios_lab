//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 05/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@end

@implementation CardGameViewController


-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

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
        for (PlayingCard *card in self.game.scoreHelper.cards){
            [self.scoreHistory appendFormat:@"%@", card.contents];
        }
        [self.scoreHistory appendFormat:@"\tScore:%d Total Score: %d\n", self.game.scoreHelper.lastScore, self.game.scoreHelper.totalScore];
    }
}

-(void)updateUI:(BOOL)firstTime
{
    
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.scoreHelper.totalScore];
        self.msgArea.text = self.game.scoreHelper.descr;
        cardButton.enabled = !card.isMatched;
    }
}

-(IBAction)resetUI:(UIButton *)sender
{
    self.scoreLabel.text = @"Score: 0";
    self.msgArea.text = @"";
    self.game = nil;
    [self.scoreHistory deleteCharactersInRange:NSMakeRange(0, [self.scoreHistory length])];
    [self updateUI:YES];
}

-(NSUInteger)gameMode
{
    return 2;
}

-(NSString *)titleForCard:(Card *)card
{
    if (card.isChosen){
        return card.contents;
    } else {
        return @"";
    }
}

-(UIImage *)backgroundImageForCard:(Card *)card
{
    if (card.isChosen) {
        return [UIImage imageNamed:@"cardfront"];
    } else {
        return [UIImage imageNamed:@"cardback"];
    }
}

@end
