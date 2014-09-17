//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 05/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCardView.h"
#import "PlayingCard.h"

@interface CardGameViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *grid;

@end

@implementation CardGameViewController


// Implementing Gesture recognizers
-(void)setTapGesture
{
    UITapGestureRecognizer *tapgr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self.grid addGestureRecognizer:tapgr];
}

-(void)tap:(UITapGestureRecognizer *)tapgr
{
    CGPoint tapoint = [tapgr locationInView:self.grid];
    NSIndexPath *tappedCellPath = [self.grid indexPathForItemAtPoint:tapoint];
    
    if (tappedCellPath)
    {
        [self.grid selectItemAtIndexPath:tappedCellPath
                                animated:YES
                          scrollPosition:UICollectionViewScrollPositionBottom];
        PlayingCardView *pcview = (PlayingCardView *)[self.grid cellForItemAtIndexPath:tappedCellPath];
        
        if (tapgr.state == UIGestureRecognizerStateEnded) {
            Card *card = [self.game cardAtIndex:tappedCellPath.item];
            [UIView transitionWithView:pcview
                              duration:0.5
                               options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                                   card.chosen = !card.chosen;
                                   //[self updateView:gesture.view forCard:card];
                               } completion:^(BOOL finished) {
                                   card.chosen = !card.chosen;
                                   [self.game chooseCardAtIndex:tappedCellPath.item];
                                   [self updateUI:NO];
                               }];
        }
        
    }
    
}

// Subclassing UICollectionView
- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        [self setEdgesForExtendedLayout:UIRectEdgeNone];
    }
    self.numCards = 20;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.grid setCollectionViewLayout:layout];
    [self.grid setDataSource:self];
    [self.grid setDelegate:self];
    self.grid.alwaysBounceVertical = YES;
    [self.grid registerClass:[PlayingCardView class] forCellWithReuseIdentifier:@"PlayingCellID"];
    [self setTapGesture];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.numCards;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PlayingCardView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PlayingCellID" forIndexPath:indexPath];
    PlayingCard *card = [self.game cardAtIndex:indexPath.item];
    [cell setupViewWithCard:card];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(40, 60);
}

// Subclassing AbstractGameViewController

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


-(void)updateUI:(BOOL)firstTime
{
    for (int ix = 0; ix < [self.grid numberOfItemsInSection:0];ix++)
    {
        NSIndexPath *myIP =  [NSIndexPath indexPathForItem:ix inSection:0];
        PlayingCard *card = [self.game cardAtIndex:ix];
        PlayingCardView *pcview = (PlayingCardView *)[self.grid cellForItemAtIndexPath:myIP];
        [pcview setFaceUp:card.isChosen];
        [pcview setAlpha: [card isChosen] && !card.isMatched ? 1.0 : 0.8];
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.scoreHelper.totalScore];
    self.msgArea.text = self.game.scoreHelper.descr;
}

-(IBAction)resetUI:(UIButton *)sender
{
    self.scoreLabel.text = @"Score: 0";
    self.msgArea.text = @"";
    self.game = nil;
    [self updateUI:YES];
}

-(NSUInteger)gameMode
{
    return 2;
}


@end
