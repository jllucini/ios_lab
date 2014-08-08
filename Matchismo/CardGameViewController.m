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
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *modeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *gameModeSelector;
@property (weak, nonatomic) IBOutlet UILabel *msgArea;
@end

@implementation CardGameViewController

-(CardMatchingGame *)game
{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                          usingDeck:[self createDeck]];
        _game.gameMode = [self gameMode];
    }
    return _game;
}

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    if (self.gameModeSelector.enabled) self.gameModeSelector.enabled = NO;
    NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
        self.msgArea.text = self.game.scoreDescr;
    }
}

- (IBAction)resetUI:(UIButton *)sender
{
    self.gameModeSelector.enabled = YES;
    self.scoreLabel.text = @"Score: 0";
    self.msgArea.text = @"";
    self.game = nil;
    [self updateUI];
}

- (IBAction)changeGameMode:(UISwitch *)sender
{
    self.modeLabel.text = ([self gameMode] == 2) ? @"Match 2" : @"Match 3";
    self.game.gameMode = [self gameMode];
}

-(NSUInteger)gameMode
{
    return ([self.gameModeSelector isOn]) ? 2 : 3;
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
