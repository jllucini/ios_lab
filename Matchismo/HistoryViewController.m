//
//  HistoryViewController.m
//  Matchismo
//
//  Created by Jose Luis Lucini Reviriego on 17/08/14.
//  Copyright (c) 2014 JLLucini. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;
@property (nonatomic, readwrite) NSString *historyString;
@end

@implementation HistoryViewController

- (NSString *)historyString
{
    return _historyString ? _historyString : @"";
}

-(void)setHistory:(NSString *)history
{
    self.historyString = history;
}

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.historyTextView setTextContainerInset:UIEdgeInsetsMake(12, 12, 12, 12)];
    NSAttributedString *nsas = [[NSAttributedString alloc] initWithString:self.historyString];
    [self.historyTextView.textStorage  setAttributedString:nsas];
    [self.historyTextView.textStorage addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont fontWithName:@"arial" size:12]}
                                          range:NSMakeRange(0, [self.historyString length])];
    NSRange range = NSMakeRange(self.historyTextView.text.length - 1, 1);
    [self.historyTextView scrollRangeToVisible:range];
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
