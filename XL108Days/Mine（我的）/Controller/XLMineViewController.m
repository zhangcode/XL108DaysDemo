//
//  XLMineViewController.m
//  XL108Days
//
//  Created by Shelin on 15/12/17.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLMineViewController.h"

@interface XLMineViewController ()

@end

@implementation XLMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIButton *weChatbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 50)];
    weChatbtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:weChatbtn];
    [weChatbtn setTitle:@"微信登陆" forState:UIControlStateNormal];
    [weChatbtn addTarget:self action:@selector(weChatLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *QQbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 100, 50)];
    QQbtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:QQbtn];
    [QQbtn setTitle:@"QQ登陆" forState:UIControlStateNormal];
    [QQbtn addTarget:self action:@selector(QQLogin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *sinabtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, 100, 50)];
    sinabtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:sinabtn];
    [sinabtn setTitle:@"微博登陆" forState:UIControlStateNormal];
    [sinabtn addTarget:self action:@selector(sinaLogin:) forControlEvents:UIControlEventTouchUpInside];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)weChatLogin:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary]valueForKey:UMShareToWechatSession];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
        }
        
    });
    
    
    //得到的数据在回调Block对象形参respone的data属性
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToWechatSession  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
}

- (void)QQLogin:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}

- (void)sinaLogin:(id)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        //获取微博用户名、uid、token等
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            NSLog(@"用户名 is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
    
    
    [[UMSocialDataService defaultDataService] requestSnsInformation:UMShareToSina  completion:^(UMSocialResponseEntity *response){
        NSLog(@"SnsInformation is %@",response.data);
    }];
}

@end
