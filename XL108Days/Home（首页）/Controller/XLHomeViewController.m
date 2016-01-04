//
//  XLHomeViewController.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/2.
//  Copyright © 2015年 GreatGate. All rights reserved.
//  首页

#import "XLHomeViewController.h"
#import "XLCityViewController.h"
#import "XLSortViewController.h"
#import "XLAdImageTool.h"
#import "XLTourCell.h"
#import "XLGetTableViewData.h"
#import "XLGroupItem.h"
#import "XLCellItem.h"
#import "XLHeaderView.h"
#import "XLSelectToolBar.h"
#import "XLHomeDetailViewController.h"
#import "XLSubjectViewController.h"
#import "XLDataBase.h"
#import "XLGifHeader.h"

#define SectionHeaderViewHeight 70.f
#define SelectToolBarHeight 80.f

@interface XLHomeViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate>
{
    NSInteger _currentPage;
}
@property (nonatomic, strong) UITableView *tourTableView;
@property (nonatomic, strong) UIScrollView *imageScrollView;
@property (nonatomic, strong) NSMutableArray *tourListArray;
@property (nonatomic, strong) NSMutableArray *adImages;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) XLSelectToolBar *selectToolBar;

@end

@implementation XLHomeViewController

#pragma lazy loading 懒加载

- (UITableView *)tourTableView {
    if (!_tourTableView) {
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _tourTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tourTableView.contentInset = UIEdgeInsetsMake(kNavigationAndStatusBarHeight, 0, 0, 0);
        _tourTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tourTableView.rowHeight = 220.f;
        _tourTableView.delegate = self;
        _tourTableView.dataSource = self;
    }
    return _tourTableView;
}

- (UIScrollView *)imageScrollView {
    if (!_imageScrollView) {
        _imageScrollView = [[UIScrollView alloc] init];
        _imageScrollView.delegate = self;
        _imageScrollView.pagingEnabled = YES;
        _imageScrollView.contentSize = CGSizeMake(kScreenWidth * 3, 0);
        _imageScrollView.frame = CGRectMake(0, 0, kScreenWidth, kImageHeight);
        _imageScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _imageScrollView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.center = _topView.center;
    }
    return _pageControl;
}

- (XLSelectToolBar *)selectToolBar {
    if (!_selectToolBar) {
        _selectToolBar = [[NSBundle mainBundle] loadNibNamed:@"XLSelectToolBar" owner:nil options:nil].lastObject;
        _selectToolBar.frame = CGRectMake(0, kImageHeight, kScreenWidth, SelectToolBarHeight);
    }
    return _selectToolBar;
}

- (UIView *)topView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.frame = CGRectMake(0, 0, kScreenWidth, kImageHeight + SelectToolBarHeight + 10);
    }
    return _topView;
}

- (NSMutableArray *)tourListArray {
    if (!_tourListArray) {
        _tourListArray = [NSMutableArray array];
    }
    return _tourListArray;
}

- (NSMutableArray *)adImages {
    if (!_adImages) {
        _adImages = [NSMutableArray array];
    }
    return _adImages;
}

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addCustomSubViews];
    [self customRefreshControl];
    self.currentCityId = citySingleton.cityId;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if ([self.currentCityId isEqualToString:citySingleton.cityId]) {//没有切换城市，或者第一次进入
        [self customNavigationBar];
        [self fetchAdImages];//获取轮播图片
        NSRange range = NSMakeRange(0, 2);
        if ([XLDataBase listWithRange:range].count) {//如果数据库有数据则读取，不发送网络请求
            [self.tourListArray addObjectsFromArray:[XLDataBase listWithRange:range]];
        }else{
            [self fetchTableViewDataWithPage:0];
        }
    }else { //切换了城市
        self.currentCityId = [NSString stringWithFormat:@"%@", citySingleton.cityId];
        [self customNavigationBar];
        [self.tourListArray removeAllObjects];//移除数据源和数据库的数据
        [XLDataBase deleteList];
        CGPoint point = self.tourTableView.contentOffset;
        point.y = - kNavigationAndStatusBarHeight;
        self.tourTableView.contentOffset = point;
        [self fetchAdImages];//获取轮播图片
        [self fetchTableViewDataWithPage:0];
    }
}

#pragma mark Network 网络请求

- (void)fetchAdImages {
    [self.adImages removeAllObjects];
    [XLNetworkRequest getRequest:AD_IMAGE_URL(citySingleton.cityId) params:nil success:^(id responseObj) {
        NSArray *array = responseObj[@"data"][@"indexBanner"];
        for (NSDictionary *dict in array) {
            NSString *str = [NSString stringWithFormat:@"%@%@",IMAGE_HEAD_URL, dict[@"img"]];
            [self.adImages addObject:str];
        }
        [XLAdImageTool loadImageViewWithImageArray:self.adImages andScrollView:self.imageScrollView];
        self.pageControl.numberOfPages = self.adImages.count;
    } failure:^(NSError *error) {
    }];
}

- (void)fetchTableViewDataWithPage:(NSInteger)page {
    NSString *urlStr = [NSString stringWithFormat:@"%@%lu",HOME_TABLE_URL(citySingleton.cityId), page];
    [XLGetTableViewData getWithUrl:urlStr param:nil modelClass:[XLGroupItem class] responseBlock:^(id dataObj, NSError *error) {
        [self.tourListArray addObjectsFromArray:dataObj];
        [self.tourTableView reloadData];
        [self.tourTableView.mj_header endRefreshing];
        [self.tourTableView.mj_footer endRefreshing];
        if (error) {
            _currentPage -= 1;
        }
    }];
}

#pragma mark interface UI界面

- (void)customNavigationBar {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(cityBtnClick) title:citySingleton.cityName imageName:@"home_city_location_img"];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(searchBtnClick) title:nil imageName:@"home_search_img"];
}

- (void)addCustomSubViews {
    [self.view addSubview:self.tourTableView];
    [self.topView addSubview:self.imageScrollView];
    [self.topView addSubview:self.pageControl];
    [self.topView addSubview:self.selectToolBar];
    self.tourTableView.tableHeaderView = self.topView;
}

- (void)customRefreshControl {
    self.tourTableView.mj_header = [XLGifHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    
    XLGifHeader *header = [XLGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    self.tourTableView.mj_header = header;
    header.lastUpdatedTimeLabel.hidden = YES;
    // 隐藏状态
    header.stateLabel.hidden = YES;
    
    self.tourTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

#pragma mark Call back 回调方法

- (void)loadNewData {
    _currentPage = 0;
    [self.tourListArray removeAllObjects];
    [self fetchTableViewDataWithPage:_currentPage];
}

- (void)loadMoreData {
    _currentPage ++;
    NSRange range = NSMakeRange(_currentPage * 2, 2);
    if ([[XLDataBase listWithRange:range] count]) {
        [self.tourListArray addObjectsFromArray:[XLDataBase listWithRange:range]];
        [self.tourTableView reloadData];
        [self.tourTableView.mj_footer endRefreshing];
    }else{
        //数据库没更多数据时再网络请求
        [self fetchTableViewDataWithPage:_currentPage];
    }
}

#pragma mark Button click event 按钮点击

- (void)cityBtnClick {
    XLCityViewController *cityViewController = [[XLCityViewController alloc] init];
    [self.navigationController pushViewController:cityViewController animated:YES];
}

- (void)searchBtnClick{
    XLSortViewController *sortViewController = [[XLSortViewController alloc] init];
    [self.navigationController pushViewController:sortViewController animated:YES];
}

- (IBAction)selectToolBarBtnClick:(UIButton *)sender {
    if (sender.tag == 100) {//周边
       XLLog(@"周边");
    }else if(sender.tag == 101){//住宿
       XLLog(@"住宿");
    }else if(sender.tag == 102){//采摘
        XLLog(@"采摘");
    }else if(sender.tag == 103){//活动
        XLLog(@"活动");
    }
    XLSubjectViewController *subjectViewController = [[XLSubjectViewController alloc] init];
    [self.navigationController pushViewController:subjectViewController animated:YES];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tourListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    XLGroupItem *groupItem = self.tourListArray[section];
    return groupItem.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XLTourCell *cell = [XLTourCell tourCellWithTableView:tableView];
    if (self.tourListArray.count) {
        XLGroupItem *groupItem = self.tourListArray[indexPath.section];
        XLCellItem *cellItem = groupItem.items[indexPath.row];
        cell.cellItem = cellItem;
    }
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XLHomeDetailViewController *homeDetailViewController = [[XLHomeDetailViewController alloc] init];
    [self.navigationController pushViewController:homeDetailViewController animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    XLHeaderView *headerView = [[NSBundle mainBundle] loadNibNamed:@"XLHeaderView" owner:nil options:nil].lastObject;
    if (self.tourListArray.count) {
        XLGroupItem *groupItem = self.tourListArray[section];
        headerView.subTitleLabel.text = groupItem.subtitle;
        headerView.nameLabel.text = groupItem.name;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SectionHeaderViewHeight;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.imageScrollView) {
        [XLAdImageTool changeImageViewWithScrollView:scrollView pageControl:self.pageControl];
    }
}

@end
