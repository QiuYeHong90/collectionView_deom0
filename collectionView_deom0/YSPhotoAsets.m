//
//  YSPhotoAsets.m
//  collectionView_deom0
//
//  Created by mac on 16/6/4.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "YSPhotoAsets.h"

@implementation YSPhotoAsets

- (UIImage *)thumbImage{
    //在ios9上，用thumbnail方法取得的缩略图显示出来不清晰，所以用aspectRatioThumbnail
    if ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending) {
        return [UIImage imageWithCGImage:[self.asset aspectRatioThumbnail]];
    } else {
        return [UIImage imageWithCGImage:[self.asset thumbnail]];
    }
    
}

- (UIImage *)compressionImage{
    UIImage *fullScreenImage = [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
    NSData *data2 = UIImageJPEGRepresentation(fullScreenImage, 0.1);
    UIImage *image = [UIImage imageWithData:data2];
    fullScreenImage = nil;
    data2 = nil;
    return image;
}

- (UIImage *)originImage{
    UIImage *image = [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
    return image;
}

- (UIImage *)fullResolutionImage{
    ALAssetRepresentation *rep = [self.asset defaultRepresentation];
    CGImageRef iref = [rep fullResolutionImage];
    
    return [UIImage imageWithCGImage:iref scale:[rep scale] orientation:(UIImageOrientation)[rep orientation]];
}

- (BOOL)isVideoType{
    NSString *type = [self.asset valueForProperty:ALAssetPropertyType];
    //媒体类型是视频
    return [type isEqualToString:ALAssetTypeVideo];
}

- (NSURL *)assetURL{
    return [[self.asset defaultRepresentation] url];
}


@end
