//
//  ViewController.m
//  QSRatingStarView
//
//  Created by qizhijian on 16/1/11.
//  Copyright © 2016年 qizhijian. All rights reserved.
//

#import "ViewController.h"
#import "QSRatingView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    QSRatingView *view = [[QSRatingView alloc] initWithFrame:CGRectMake(10, 100, CGRectGetWidth(self.view.frame)-20, 50) andStarCount:5];
    [self.view addSubview:view];
}

@end
