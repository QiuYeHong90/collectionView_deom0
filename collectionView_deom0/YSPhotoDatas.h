//
//  YSPhotoDatas.h
//  collectionView_deom0
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YSPhotoGroup;

typedef void(^groupCallBackBlock)(id);

@interface YSPhotoDatas : NSObject
//返回一个组
-(void)getGroupWithResource : (groupCallBackBlock ) callBack;
//根据哪个个组来获取 图片
-(void)getAssetsWithGroup:(YSPhotoGroup*)group  finished: (groupCallBackBlock)callBack;
//根据url获取图片
- (void) getAssetsPhotoWithURLs:(NSURL *) url callBack:(groupCallBackBlock) callBack;


@end
