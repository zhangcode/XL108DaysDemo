//
//  XLSubjectViewController.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/7.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLSubjectViewController.h"
#import "XLFunctionToolBar.h"
#define FunctionToolBarHeight 40

@interface XLSubjectViewController ()

@property (nonatomic, strong) XLFunctionToolBar *functionToolBar;

@end

@implementation XLSubjectViewController

#pragma mark lazy loading 懒加载

- (XLFunctionToolBar *)functionToolBar {
    if (!_functionToolBar) {
        _functionToolBar = [[NSBundle mainBundle] loadNibNamed:@"XLFunctionToolBar" owner:nil options:nil].lastObject;
        _functionToolBar.frame = CGRectMake(0, kNavigationAndStatusBarHeight, kScreenWidth, FunctionToolBarHeight);
    }
    return _functionToolBar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.functionToolBar];
}


@end
