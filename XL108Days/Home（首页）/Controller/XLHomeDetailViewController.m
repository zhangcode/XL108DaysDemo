//
//  XLHomeDetailViewController.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/7.
//  Copyright © 2015年 GreatGate. All rights reserved.
//  首页cell详情

#import "XLHomeDetailViewController.h"
#import "XLZoomHeaderView.h"
#import "XLDetailItem.h"
#import "XLDetailCell.h"
#import "XLSharedView.h"
#import "XLRowHeightItem.h"

#define kDetailHeadimageWidth kScreenWidth
#define kDetailHeadimageHeight 250

@interface XLHomeDetailViewController () <UITableViewDelegate, UITableViewDataSource,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *detailTableView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) NSMutableArray *detailItems;
@property (strong, nonatomic) IBOutlet XLSharedView *sharedView;

@end

@implementation XLHomeDetailViewController

#pragma mark lazy loading 懒加载

- (UITableView *)detailTableView {
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] init];
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.delegate = self;
        _detailTableView.dataSource = self;
        _detailTableView.frame = self.view.bounds;
    }
    return _detailTableView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.image = [UIImage imageNamed:@"DetailHeadImage.jpg"];
        //DetailHeadImage.jpg
        _headImageView.frame = CGRectMake(0, 0, kDetailHeadimageWidth, kDetailHeadimageHeight);
    }
    return _headImageView;
}

- (NSMutableArray *)detailItems {
    if (!_detailItems) {
        _detailItems = [NSMutableArray array];
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"HomePageDetail"ofType:@"json"];
        NSData *jData = [[NSData alloc] initWithContentsOfFile:jsonPath];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jData options:NSJSONReadingMutableContainers error:nil];
        NSArray *detail = jsonObject[@"data"][@"detail"];
        for (NSString *detailStr in detail) {
            XLDetailItem *detailItem = [[XLDetailItem alloc] init];
            detailItem.detailStr = detailStr;
            XLRowHeightItem *rowHeightItem = [[XLRowHeightItem alloc] init];
            rowHeightItem.detailItem = detailItem;
            [_detailItems addObject:rowHeightItem];
        }
    }
    return _detailItems;
}

- (XLSharedView *)sharedView {

    if (!_sharedView) {
        _sharedView = [[XLSharedView alloc] init];
        _sharedView.backgroundColor = [UIColor redColor];
        _sharedView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
        
        UIButton *sinabtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 40, 100, 30)];
        sinabtn.backgroundColor = [UIColor grayColor];
        [_sharedView addSubview:sinabtn];
        [sinabtn setTitle:@"新浪" forState:UIControlStateNormal];
        [sinabtn addTarget:self action:@selector(sinaShared:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *QQbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 100, 100, 30)];
        QQbtn.backgroundColor = [UIColor grayColor];
        [_sharedView addSubview:QQbtn];
        [QQbtn setTitle:@"QQ好友" forState:UIControlStateNormal];
        [QQbtn addTarget:self action:@selector(QQShared:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *weChatbtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 160, 100, 30)];
        weChatbtn.backgroundColor = [UIColor grayColor];
        [_sharedView addSubview:weChatbtn];
        [weChatbtn setTitle:@"微信好友" forState:UIControlStateNormal];
        [weChatbtn addTarget:self action:@selector(weChatShared:) forControlEvents:UIControlEventTouchUpInside];

        
    }
    return _sharedView;
}

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    XLLog(@"%@",self.detailItems);
    [self customUserInterface];
    self.detailTableView.rowHeight = 200;
    
}

#pragma mark interface UI界面

- (void)customUserInterface {
    self.navigationController.navigationBar.alpha = 0.f;
    UIBarButtonItem *rightBarButton1 = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(likeBtnClick) title:nil imageName:@"list_product_save_tag_img"];
    UIBarButtonItem *rightBarButton2 = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(shareBtnClick) title:nil imageName:@"nav_share@2x"];
    self.navigationItem.rightBarButtonItems = @[rightBarButton2, rightBarButton1];
    
    [self.view addSubview:self.detailTableView];
    
    [XLZoomHeaderView customZoomHeaderViewWithTableView:self.detailTableView HeaderView:self.headImageView];
    [self.view addSubview:self.headImageView];
    
    [self.view addSubview:self.sharedView];
}


#pragma mark Button click event 按钮点击

- (void)likeBtnClick {
    XLLog(@"喜欢");
}

- (void)shareBtnClick {
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.sharedView.frame;
        frame = CGRectMake(0, kScreenHeight - 200, kScreenWidth, 200);
        self.sharedView.frame = frame;
    }];
}

/**
 *  以下友盟第三方分享测试
 *
 */
- (void)sinaShared:(id)sender {
    NSLog(@"新浪");
    
    [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"DetailHeadImage.jpg"] socialUIDelegate:nil];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
}

- (void)weChatShared:(id)sender {
    NSLog(@"微信好友");
    
    //使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatSession] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

- (void)wechatTimelineShared:(id)sender {
    NSLog(@"微信朋友圈");
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
    
}

- (void)messageShared:(id)sender {
    
    NSLog(@"短信");

    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSms] content:@"分享内嵌文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

- (void)QQShared:(id)sender {
    NSLog(@"QQ好友");
    
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQQ] content:@"分享文字" image:nil location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:0.25 animations:^{
        CGRect frame = self.sharedView.frame;
        frame = CGRectMake(0, kScreenHeight, kScreenWidth, 200);
        self.sharedView.frame = frame;
    }];
}

#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.detailItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XLDetailCell *cell = [XLDetailCell detailCellWithTableView:tableView];
    XLRowHeightItem *rowHeightItem = self.detailItems[indexPath.row];
    cell.detailItem = rowHeightItem.detailItem;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLRowHeightItem *rowHeightItem = self.detailItems[indexPath.row];
    return rowHeightItem.cellHeight;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [XLZoomHeaderView updateHeaderViewFrameWithScrollView:scrollView];
    CGFloat yOffset = scrollView.contentOffset.y;
    if (yOffset > 0) {
        self.navigationController.navigationBar.alpha = (yOffset <= kNavigationAndStatusBarHeight ?  yOffset : kNavigationAndStatusBarHeight) / kNavigationAndStatusBarHeight;
    }else {
        self.navigationController.navigationBar.alpha = 0.f;
    }
}

@end
