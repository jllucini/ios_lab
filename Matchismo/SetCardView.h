//
//  SetCardView.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 31/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SetCard.h"

@interface SetCardView : UICollectionViewCell

//@property (nonatomic) NSNumber *number;

- (void)setupViewWithCard:(SetCard *) setCard;

@end
