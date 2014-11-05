//
//  CircleLayout.h
//  collectionViewDemo
//
//  Created by jyl on 14-11-5.
//  Copyright (c) 2014年 jyl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleLayout : UICollectionViewLayout
@property(nonatomic,assign)CGPoint center;
@property(nonatomic,assign)CGFloat radius;
@property(nonatomic,assign)NSInteger cellCount;
@end
