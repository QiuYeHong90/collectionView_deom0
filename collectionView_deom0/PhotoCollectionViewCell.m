//
//  photoCollectionViewCell.m
//  SinaApp_MVC
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 SuperWang. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.button.layer.cornerRadius =CGRectGetWidth(self.button.frame)/2;
    self.button.clipsToBounds = YES;
}
- (IBAction)buttonClick:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected ==YES) {
        sender.backgroundColor = [UIColor redColor];
    }else{
        sender.backgroundColor = [UIColor whiteColor];
    }
    self.buttonClick(self,sender);
}

@end
