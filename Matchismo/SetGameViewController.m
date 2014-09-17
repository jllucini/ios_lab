//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 10/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCardView.h"
#import "SetCard.h"

@interface SetGameViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *grid;
@property (weak, nonatomic) IBOutlet UIButton *moreCards;
@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation SetGameViewController

-(UIDynamicAnimator *)animator
{
    if (!_animator){
        _animator = [[UIDynamicAnimator alloc]initWithReferenceView:self.grid];
    }
    return _animator;
}

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
        [self.game chooseCardAtIndex:tappedCellPath.item];
        [self updateUI:NO];
        
    }
        
}

- (IBAction)moreCards:(id)sender
{
    NSArray *cards = [self.game moreCards:3 usingDeck:self.deck];
       
    if (cards){
        for (SetCard *card in cards) {
            self.numCards += 1;
            SetCardView *scv = [[SetCardView alloc]init];
            [scv setupViewWithCard:card];
            [self.grid insertItemsAtIndexPaths:
             [NSArray arrayWithObject:[NSIndexPath indexPathForItem:self.numCards-1 inSection:0]]];
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
    self.numCards = 12;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.grid setCollectionViewLayout:layout];
    [self.grid setDataSource:self];
    [self.grid setDelegate:self];
    self.grid.alwaysBounceVertical = YES;
    [self.grid registerClass:[SetCardView class] forCellWithReuseIdentifier:@"SetCellID"];
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
    SetCardView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SetCellID" forIndexPath:indexPath];
    SetCard *card = [self.game cardAtIndex:indexPath.item];
    [cell setupViewWithCard:card];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}



// Subclassing AbstractGameViewController

-(IBAction)resetUI:(UIButton *)sender
{
    self.scoreLabel.text = @"Score Set: 0";
    self.msgArea.text = @"";
    self.game = nil;
    self.deck = nil;
    self.numCards = 12;
    [self.grid reloadData];
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
    NSMutableArray *matchedCards = [[NSMutableArray alloc]init];
    NSMutableIndexSet *indexSet  = [[NSMutableIndexSet alloc]init];
    for (int ix = 0; ix < [self.grid numberOfItemsInSection:0];ix++)
    {
        NSIndexPath *myIP =  [NSIndexPath indexPathForItem:ix inSection:0];
        SetCard *card = [self.game cardAtIndex:ix];
        SetCardView *scview = (SetCardView *)[self.grid cellForItemAtIndexPath:myIP];
        [scview setAlpha: [card isChosen] && !card.isMatched ? 0.8 : 1.0];
        if (card.isChosen && card.isMatched){
            [matchedCards addObject:myIP];
            [indexSet addIndex:ix];
            card.chosen = FALSE;
        }
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.scoreHelper.totalScore];
        self.msgArea.text = self.game.scoreHelper.descr;
    }
    
    // Remove MAtched Cards
    
    if ([matchedCards count] == 3){
        [self.grid performBatchUpdates:^{
            self.numCards -= 3;
            [self.game removeCardsAtIndex:indexSet];
            [self.grid deleteItemsAtIndexPaths:matchedCards];
            } completion:^(BOOL finished) {
        }];
    }
}

@end
