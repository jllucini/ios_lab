//
//  ScoreHelper.h
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 17/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreHelper : NSObject

@property (nonatomic,readwrite) NSInteger totalScore;
@property (nonatomic,readwrite) NSInteger lastScore;
@property (nonatomic,readwrite) NSString *descr;
@property (nonatomic,readwrite) NSMutableArray *cards;

-(void)setData:(NSInteger)totalScore lastScore:(NSInteger)lastScore descr:(NSString *)descr cards:(NSMutableArray *)cards;

@end
