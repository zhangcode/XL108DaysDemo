//
//  XLActivityViewController.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/2.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLActivityViewController.h"

@interface XLActivityViewController ()

@end

@implementation XLActivityViewController

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customNavigationBar];
}

#pragma mark interface

- (void)customNavigationBar {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(sortBtnClick) title:nil imageName:@"active_nav_right_btn"];
}

#pragma mark Button click event

- (void)sortBtnClick {
    
    NSLog(@"排序");
}

@end
