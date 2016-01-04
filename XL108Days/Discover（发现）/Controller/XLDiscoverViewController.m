//
//  XLDiscoverViewController.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/2.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLDiscoverViewController.h"
#import "XLRecommendView.h"
#import "XLPastReviewCell.h"
#import "XLGetPastReviewCollData.h"
#import "XLPastReviewItem.h"

#define kPastReviewCellWidth kScreenWidth * (145 / 320.0)
#define kPastReviewCellHeight kPastReviewCellWidth * (200 / 145.0)
#define kMagin (kScreenWidth - 2 * kPastReviewCellWidth) / 3

@interface XLDiscoverViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSInteger _currentPage;
}
@property (nonatomic, strong) XLRecommendView *recommendView;
@property (nonatomic, strong) UICollectionView *pastReviewCollectionView;
@property (nonatomic, strong) NSMutableArray *pastReviewArray;
@end

@implementation XLDiscoverViewController

#pragma lazy loading 懒加载

- (NSMutableArray *)pastReviewArray {
    if (!_pastReviewArray) {
        _pastReviewArray = [NSMutableArray array];
    }
    return _pastReviewArray;
}

- (XLRecommendView *)recommendView {
    if (!_recommendView) {
        _recommendView = [[NSBundle mainBundle] loadNibNamed:@"XLRecommendView" owner:nil options:nil].lastObject;
        _recommendView.frame = CGRectMake(0, 0, kScreenWidth, 300 );
    }
    return _recommendView;
}

- (UICollectionView *)pastReviewCollectionView {
    if (!_pastReviewCollectionView) {
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        _pastReviewCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kNavigationAndStatusBarHeight, kScreenWidth, kScreenHeight) collectionViewLayout:layout];
        _pastReviewCollectionView.delegate = self;
        _pastReviewCollectionView.dataSource = self;
        _pastReviewCollectionView.backgroundColor = [UIColor whiteColor];
        [_pastReviewCollectionView registerNib:[UINib nibWithNibName:@"PostListCell" bundle:nil] forCellWithReuseIdentifier:@"PostListCell"];
        
    }
    return _pastReviewCollectionView;
}

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = nil;
    [self.view addSubview:self.recommendView];
    
    [self fetchPastReviewCollectionViewDataWithPage:0];
    [self customPastReviewCollectionView];
    [self customRefreshControl];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark interface UI界面

- (void)customPastReviewCollectionView {
    [self.view addSubview:self.pastReviewCollectionView];
    [self.pastReviewCollectionView addSubview:self.recommendView];
}

- (void)customRefreshControl {
    self.pastReviewCollectionView.mj_header = [XLGifHeader headerWithRefreshingBlock:^{
        [self loadNewData];
    }];
    self.pastReviewCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadMoreData];
    }];
}

#pragma mark Network 网络请求

- (void)fetchPastReviewCollectionViewDataWithPage:(NSInteger)page {
    NSString *urlStr = [NSString stringWithFormat:@"%@%lu",PAST_REVIEW_URL(citySingleton.cityId), page];
//    XLLog(@"____%@",urlStr);
    [XLGetPastReviewCollData getWithUrl:urlStr param:nil modelClass:[XLPastReviewItem class] responseBlock:^(id dataObj, NSError *error) {
        [self.pastReviewArray addObjectsFromArray:dataObj];
        [self.pastReviewCollectionView reloadData];
    }];
}

#pragma mark Call back 回调方法

- (void)loadNewData {
    _currentPage = 0;
    [self.pastReviewArray removeAllObjects];
    [self fetchPastReviewCollectionViewDataWithPage:0];
}   

- (void)loadMoreData {
    _currentPage ++;
//    XLLog(@"_currentPage--%lu",_currentPage);
    [self fetchPastReviewCollectionViewDataWithPage:_currentPage];
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.pastReviewArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XLPastReviewCell *cell = [XLPastReviewCell pastReviewCellWithCollectionView:collectionView IndexPath:indexPath];
    cell.pastReviewItem = self.pastReviewArray[indexPath.row];
    return cell;
}

#pragma mark UICollectionViewDelegate

//cell尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    //按屏幕缩放
    return CGSizeMake(kPastReviewCellWidth, kPastReviewCellHeight);
}

//设置整体内边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(250 + kNavigationAndStatusBarHeight, kMagin, kTabBarHeight, kMagin);
}

//行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return kMagin;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath");
}


@end
