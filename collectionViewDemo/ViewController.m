//
//  ViewController.m
//  collectionViewDemo
//
//  Created by jyl on 14-11-5.
//  Copyright (c) 2014年 jyl. All rights reserved.
//

#import "ViewController.h"
#import "Cell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellCount=20;
    UITapGestureRecognizer *tapRecognizer=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [self.collectionView addGestureRecognizer:tapRecognizer];
    [self.collectionView registerClass:[Cell class] forCellWithReuseIdentifier:@"MY_CELL"];
    [self.collectionView reloadData];
    self.collectionView.backgroundColor=[UIColor orangeColor];
    
//    UICollectionViewLayout *layout=[[UICollectionViewLayout alloc] init];
    //在初始化一个UICollectionViewLayout实例后，会有一系列准备方法被自动调用，以保证layout实例的正确
    //首先prepareLayout将被调用，默认什么也不做，但是在自己的子类实现中，一般在该方法中设定一些必要的layout的结构和初始化需要的参数等
    //之后-(CGSize)collectionViewContentSize被调用，确定collection应该占据的尺寸。注意这里的尺寸不是指可见部分的尺寸，而应该是所有内容所占的尺寸。collectionView的本质是一个scrollView，因此需要这个尺寸来配置滚动行为
    
    //UICollectionViewLayoutAttributes
//    UICollectionViewLayoutAttributes *attributes=[[UICollectionViewLayoutAttributes alloc] init];
//    attributes.frame
//    attributes.center
//    attributes.size
//    attributes.transform3D
//    attributes.alpha
//    attributes.zIndex
//    attributes.hidden
//    当UICollectionView在获取布局时将针对每一个indexPath的部件，向其上的UICollectionViewLayout实例询问该部件信息，这个布局信息就以UICollectionViewLayoutAttributes的形式给出
}

-(void)handleTapGesture:(UITapGestureRecognizer *)sender{
    /*
     performBatchUpdates:completion:
     再次展示了block的强大之处，可以用来对collectionView中的元素进行批量的插入、删除、移动等操作
     同时将触发collectionView所对应的layout的对应的动画
     */
    if (sender.state==UIGestureRecognizerStateEnded) {
        CGPoint initialPinchPoint=[sender locationInView:self.collectionView];
        NSIndexPath *tappedCellPath=[self.collectionView indexPathForItemAtPoint:initialPinchPoint];
        if (tappedCellPath!=nil) {
            self.cellCount=self.cellCount-1;
            [self.collectionView performBatchUpdates:^{
                [self.collectionView deleteItemsAtIndexPaths:[NSArray arrayWithObject:tappedCellPath]];
            } completion:nil];
        }else{
            self.cellCount=self.cellCount+1;
            [self.collectionView performBatchUpdates:^{
                [self.collectionView insertItemsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:0]]];
            } completion:nil];
        }
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.cellCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    Cell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MY_CELL" forIndexPath:indexPath];
    return cell;
}



@end
