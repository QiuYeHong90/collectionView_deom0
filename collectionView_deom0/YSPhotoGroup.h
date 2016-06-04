//
//  YSPhotoGroup.h
//  collectionView_deom0
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@import UIKit;

@interface YSPhotoGroup : NSObject
@property (nonatomic,copy) NSString * groupName;
@property (nonatomic,strong) UIImage * thumbImage;
@property (nonatomic,assign) NSInteger assetsCount;
@property (nonatomic,copy) NSString * type;
@property (nonatomic,strong) ALAssetsGroup * group;
@end
