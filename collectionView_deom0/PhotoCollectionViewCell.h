//
//  photoCollectionViewCell.h
//  SinaApp_MVC
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bmageView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (nonatomic,copy) void (^buttonClick)(PhotoCollectionViewCell*,UIButton*);
@property (nonatomic,strong)NSIndexPath *
indexPath;

@end
