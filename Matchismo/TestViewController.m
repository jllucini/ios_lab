//
//  TestViewController.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 31/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "TestViewController.h"
#import "SetCard.h"


@interface TestViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *grid;
@property (nonatomic) BOOL dotres ;

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
     self.dotres = YES;
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    //[layout setItemSize:CGSizeMake(80, 80)];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.grid setCollectionViewLayout:layout];
    [self.grid setDataSource:self];
    [self.grid setDelegate:self];
    self.grid.alwaysBounceVertical = YES;
    [self.grid registerClass:[SetCardView class] forCellWithReuseIdentifier:@"cellID"];
    [self.grid setBackgroundColor:[UIColor redColor]];
    
    //[self.view addSubview:self.grid];
    [super viewDidLoad];
}

- (IBAction)click:(id)sender {
    
    self.dotres = !self.dotres;
    NSIndexPath *ixpath = [NSIndexPath indexPathForItem:1 inSection:0];
    NSArray *arr =@[ixpath];
    
    [self.grid reloadItemsAtIndexPaths:arr ];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 25;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SetCardView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    // Do any additional setup after loading the view.
    SetCard *card = [[SetCard alloc]init];
    card.color = [SetCard validColors][@"green"];
    if (self.dotres){
        card.shading = @SHADING_STRIPED;
    } else {
        card.shading = @SHADING_OPEN;
    }
    card.shape  = @SHAPE_SQUIGGLE;
    card.number = @3;
    [cell setupViewWithCard:card];
     
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
