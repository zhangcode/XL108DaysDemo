//
//  XLCityViewController.m
//  XL108Days
//  我的GitHub：https://github.com/ShelinShelin
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import "XLCityViewController.h"
#import "XLSearchBar.h"
#import "XLCityModel.h"

@interface XLCityViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *cityListArray;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XLSearchBar *searchBar;

@end

@implementation XLCityViewController

#pragma lazy loading

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (XLSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [XLSearchBar searchBar];
        [self.view addSubview:_searchBar];
    }
    return _searchBar;
}

- (NSMutableArray *)cityListArray {
    if (!_cityListArray) {
        _cityListArray = [NSMutableArray array];
    }
    return _cityListArray;
}

#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(backBtnClick) title:nil imageName:@"back_setting_icon_jump"];
    
    [self fetchCityData];
    
    [self.view setNeedsUpdateConstraints];
}

#pragma mark Screen constraints

- (void)updateViewConstraints {
    if (!self.didSetupConstraints) {
        
        [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:10.0];
        [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:10.0];
        [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:74.0];
        [self.searchBar autoSetDimension:ALDimensionHeight toSize:30.0];
        
        [self.tableView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.searchBar withOffset:10.0];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeRight];
        [self.tableView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        self.didSetupConstraints = YES;
    }
    [super updateViewConstraints];
}

#pragma mark fetch data

- (void)fetchCityData {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *cityDict = [defaults dictionaryForKey:@"cityDict"];
    if (cityDict) {
        [self modelWithCityDict:cityDict];
    }else {//归档
        [XLNetworkRequest getRequest:CITYLIST_URL params:nil success:^(id responseObj) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSDictionary *cityDict = responseObj[@"data"][@"openCity"];
            [defaults setObject:cityDict forKey:@"cityDict"];
            [defaults synchronize];
            [self modelWithCityDict:cityDict];
            [self.tableView reloadData];
        } failure:^(NSError *error) {
        }];
    }
}

- (void)modelWithCityDict:(NSDictionary *)cityDict {
    for (NSString *key in cityDict) {
        NSArray *cityArray = cityDict[key];
        for (NSDictionary *dict in cityArray) {
            [XLCityModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
                return @{ @"ID" : @"id"};
            }];
            XLCityModel *city = [XLCityModel mj_objectWithKeyValues:dict];
            [self.cityListArray addObject:city];
        }
    }
}

#pragma mark btn Click

- (void)backBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cityListArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cityListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    XLCityModel *city = self.cityListArray[indexPath.row];
    cell.textLabel.text = city.name;
    return cell;

}

#pragma  mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self backBtnClick];
    
    XLCityModel *city = self.cityListArray[indexPath.row];
    citySingleton.cityName = city.name;
    citySingleton.cityId = [NSString stringWithFormat:@"%@",city.ID];
    
    //存档当前城市
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:citySingleton.cityId forKey:@"cityId"];
    [defaults setObject:citySingleton.cityName forKey:@"cityName"];
    [defaults synchronize];
}

@end
