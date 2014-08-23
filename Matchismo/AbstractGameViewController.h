//
//  AbstractGameViewController.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 11/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"
#import "HistoryViewController.h"

@interface AbstractGameViewController : UIViewController

@property (strong, nonatomic) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgArea;
@property (strong, nonatomic) NSMutableString *scoreHistory;

-(Deck *)createDeck;
-(void)updateUI:(BOOL)firstTime;
-(NSUInteger)gameMode;

@end
