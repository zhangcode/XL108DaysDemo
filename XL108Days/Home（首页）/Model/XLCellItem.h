//
//  XLCellItem.h
//  XL108Days
//
//  Created by Shelin on 15/12/4.
//  Copyright © 2015年 GreatGate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLCellItem : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSArray *lnglat;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSNumber *fav;
@property (nonatomic, strong) NSNumber *startTime;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSArray *lngLatitude;

@end
