//
//  ViewController.h
//  collectionView_deom0
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,copy) NSArray *(^dataBlock)(UIImage*image);
@end

