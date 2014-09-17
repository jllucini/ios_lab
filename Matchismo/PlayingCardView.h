//
//  PlayingCardView.h
//  SuperCard
//
//  Created by CS193p Instructor.
//  Copyright (c) 2013 Stanford University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayingCard.h"

@interface PlayingCardView: UICollectionViewCell

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;
@property (nonatomic) BOOL faceUp;

- (void)setupViewWithCard:(PlayingCard *) setCard;
- (void)pinch:(UIPinchGestureRecognizer *)gesture;

@end
