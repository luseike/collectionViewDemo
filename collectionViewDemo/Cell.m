//
//  Cell.m
//  collectionViewDemo
//
//  Created by jyl on 14-11-5.
//  Copyright (c) 2014年 jyl. All rights reserved.
//

#import "Cell.h"

@implementation Cell
-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.contentView.layer.cornerRadius=35.0;
        self.contentView.layer.borderWidth=1.0f;
        self.contentView.layer.borderColor=[UIColor whiteColor].CGColor;
        self.contentView.backgroundColor=[UIColor groupTableViewBackgroundColor];
    }
    return self;
}
@end
