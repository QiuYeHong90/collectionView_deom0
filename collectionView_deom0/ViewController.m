//
//  PhotosViewController.m
//  SinaApp_MVC
//
//  Created by mac on 16/5/26.
//  Copyright © 2016年 SuperWang. All rights reserved.
//
#import <AssetsLibrary/AssetsLibrary.h>
#import "ViewController.h"
#import "PhotoCollectionViewCell.h"
#import "Header.h"
@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
  
    UICollectionView * _collectionView;
    NSMutableIndexSet * _mutIndexSet;
    
    NSArray * _Group;
    
    NSMutableArray * _dataArray;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
     
     */
  
    [self createCollectionView];
      [self takePhotoImage];
    [self createButton];
    
}
- (void)performBatchUpdates:(void (^ __nullable)(void))updates completion:(void (^ __nullable)(BOOL finished))completion
{
    
}

-(void)addObjectAtIndexSet
{
   
}

-(void)createButton
{
    UIButton * buttonSelectAll = [[UIButton alloc]initWithFrame:CGRectMake(20, 20, 70, 40)];
    [buttonSelectAll setTitle:@"全选" forState:UIControlStateNormal];
    [buttonSelectAll setTitle:@"取消全选" forState:UIControlStateSelected];
    buttonSelectAll.tag = 1;
    buttonSelectAll.backgroundColor = [UIColor blackColor];
    [self.view addSubview:buttonSelectAll];
    [buttonSelectAll addTarget:self action:@selector(buttonCick:) forControlEvents:UIControlEventTouchUpInside];
    UIButton * buttonNext = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)- 20-70, 20, 70, 40)];
    [buttonNext setTitle:@"下一步" forState:UIControlStateNormal];
    buttonNext.tag = 2;
    buttonNext.backgroundColor = [UIColor blackColor];
    [self.view addSubview:buttonNext];
    [buttonNext addTarget:self action:@selector(buttonCick:) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonCick:(UIButton*)btn

{
    if (btn.tag==1) {
        NSLog(@"---全选");
       
        if (btn.selected==0) {
            for (NSUInteger index = 0; index < _dataArray.count; ++index) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                
                if ([self collectionView:_collectionView shouldSelectItemAtIndexPath:indexPath]) {
                    
                    [_collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];
                    
                    [_mutIndexSet addIndex:indexPath.item];
                    
                }
            }
        
        }else{
            NSLog(@"全部选");
            [_mutIndexSet enumerateIndexesUsingBlock:^(NSUInteger index, BOOL * _Nonnull stop) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
                
                if ([self collectionView:_collectionView shouldDeselectItemAtIndexPath:indexPath]) {
                    
                    [_collectionView deselectItemAtIndexPath:indexPath animated:YES];
                    
                    [_mutIndexSet removeIndex:indexPath.item];
                    
                }
                
            }];
            
           
        }
        
        
        
    }else{
       
        [_mutIndexSet enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"---%ld",idx);
              UIImage *image = _dataArray[idx];
//            self.dataBlock(image);
        }];
         NSLog(@"---下一步");
        
        
   }
    
}
-(void)createCollectionView
{
    _mutIndexSet = [[NSMutableIndexSet alloc]init];
    _dataArray = [[NSMutableArray alloc]init];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    _collectionView = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:flowLayout];
    _collectionView.allowsMultipleSelection = YES;
    [self.view addSubview:_collectionView];
    flowLayout.minimumLineSpacing= 10;
    flowLayout.minimumInteritemSpacing = 5;
    flowLayout.itemSize = CGSizeMake(130, 130);
    flowLayout.sectionInset = UIEdgeInsetsMake(5,5,5,5);
    _collectionView.delegate =self;
    _collectionView.dataSource = self;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //注册单元格
    [_collectionView registerNib:[UINib nibWithNibName:@"PhotoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    _collectionView.backgroundColor = [UIColor redColor];
}

//TODO:选中单元格
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"--%@",indexPath);
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.contentView.backgroundColor = [UIColor blackColor];
    
    YSPhotoAsets * aset =_dataArray[indexPath.row];
        cell.bmageView.image = aset.thumbImage;
    cell.buttonClick = ^(PhotoCollectionViewCell* obj,UIButton *btn){
        
        if (btn.selected==YES) {
            [_mutIndexSet addIndex:obj.indexPath.row];
        }else{
            [_mutIndexSet removeIndex:obj.indexPath.row];
        }
        NSLog(@"我被选中了--%@",_mutIndexSet);
    };
    
    return cell;
}

-(void)takePhotoImage
{    
    YSPhotoDatas * photoDb = [[YSPhotoDatas alloc]init];
    
    [photoDb getGroupWithResource:^(NSArray * groups) {
        _Group = groups;
        [self sssssaWith:groups And:photoDb];
    }];
    
}

-(void)sssssaWith:(NSArray *)groups And:(YSPhotoDatas*)photoDb
{
    if (_dataArray==nil) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    [photoDb getAssetsWithGroup:[groups lastObject] finished:^(NSArray * assets ) {
        [_dataArray setArray:assets];
         NSLog(@"刷新界面");
        [_collectionView reloadData];
    }];
    
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
