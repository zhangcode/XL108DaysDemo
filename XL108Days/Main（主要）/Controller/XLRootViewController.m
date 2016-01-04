//
//  XLRootViewController.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/11/26.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLRootViewController.h"

@interface XLRootViewController ()



@end

@implementation XLRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backBtnClick) title:nil imageName:@"back_setting_icon_jump"];
    
}

- (void)backBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
//    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
