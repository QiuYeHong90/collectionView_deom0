//
//  YSPhotoDatas.m
//  collectionView_deom0
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YSPhotoDatas.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "YSPhotoGroup.h"
#import "YSPhotoAsets.h"
@interface YSPhotoDatas ()
@property (nonatomic,strong) ALAssetsLibrary * library;
@end
@implementation YSPhotoDatas

+ (ALAssetsLibrary*)defaultAssetsLibrary{
    static ALAssetsLibrary* library = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    
    return library;
}

-(ALAssetsLibrary*)library
{
    if (!_library) {
        _library = [self.class defaultAssetsLibrary];
    }
    return _library;
}

-(void)getGroupWithResource : (groupCallBackBlock ) callBack
{
    NSMutableArray * groups = [[NSMutableArray alloc]init];
    [self.library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group) {
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            NSLog(@"==%@",[group posterImage]);
            YSPhotoGroup * gp = [[YSPhotoGroup alloc]init];
            gp.groupName  = [group valueForProperty:@"ALAssetsGroupPropertyName"];
            gp.thumbImage = [UIImage imageWithCGImage:[group posterImage]];
            gp.assetsCount = group.numberOfAssets;
            gp.group = group;
            gp.type = [group valueForProperty:@"ALAssetsGroupPropertyType"];
            [groups addObject:gp];
        }else{
            callBack(groups);
        }
    } failureBlock:^(NSError *error) {
        NSLog(@"--%@",error);
    }];
    
}
-(void)getAssetsWithGroup:(YSPhotoGroup*)group  finished: (groupCallBackBlock)callBack
{
    NSMutableArray * assets = [NSMutableArray array];
    [group.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            YSPhotoAsets * ypAset = [[YSPhotoAsets alloc]init];
            ypAset.asset = result;
            [assets addObject:ypAset];
        }else{
            callBack(assets);
        }
    }];
}
- (void) getAssetsPhotoWithURLs:(NSURL *) url callBack:(groupCallBackBlock ) callBack{
    [self.library assetForURL:url resultBlock:^(ALAsset *asset) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callBack([UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]);
        });
    } failureBlock:nil];
}


@end
