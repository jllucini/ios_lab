//
//  AbstractGameViewController.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 11/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface AbstractGameViewController : UIViewController

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *msgArea;
@property (weak, nonatomic) IBOutlet UICollectionView *grid;
@property (nonatomic) NSUInteger numCards;

-(Deck *)createDeck;
-(void)updateUI:(BOOL)firstTime;
-(NSUInteger)gameMode;
//-(void)setTapGesture;
//-(void)tap:(UITapGestureRecognizer *)tapgr;

@end
