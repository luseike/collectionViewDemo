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
