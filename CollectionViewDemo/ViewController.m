//
//  ViewController.m
//  CollectionViewDemo
//
//  Created by Hehuimin on 2017/8/14.
//  Copyright © 2017年 haoshiqi. All rights reserved.
//

#import "ViewController.h"
#import "ImageCollectionViewCell.h"

@interface ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionview;
@property (nonatomic, strong) NSDate *currentDate;
@property (nonatomic, strong) NSArray *arrayImages;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.arrayImages = @[@"timg.jpeg", @"timg-2.jpeg", @"timg-3.jpeg"];
    self.view.backgroundColor = [UIColor darkGrayColor];
    [self.view addSubview:self.collectionview];
    [self selcetItem];
}
- (void)selcetItem {
    NSIndexPath *path = [NSIndexPath indexPathForItem:500 *self.arrayImages.count inSection:0];
    [self.collectionview scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    NSLog(@"循环开始%ld",(long)path.item);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UICollectionView *)collectionview
{
    if (!_collectionview) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)) collectionViewLayout:flowLayout];
        _collectionview.backgroundColor = [UIColor darkGrayColor];
        [_collectionview registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ImageCollectionViewCell"];
        _collectionview.delegate = self;
        _collectionview.dataSource = self;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionview.showsVerticalScrollIndicator = NO;
        self.collectionview.showsHorizontalScrollIndicator = NO;
        self.collectionview.pagingEnabled = YES;
        
        flowLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
    }
    return _collectionview;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrayImages.count * 1000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCollectionViewCell" forIndexPath:indexPath];
    [cell.imageView setImage:[UIImage imageNamed:self.arrayImages[indexPath.item %self.arrayImages.count]]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSIndexPath *path = [self.collectionview indexPathsForVisibleItems].firstObject;
    NSUInteger item = path.item;
    NSLog(@"-----当前item---- :%ld",(long)path.item);
    if (item % self.arrayImages.count == 0) {
        [self selcetItem];
    }
}

@end
