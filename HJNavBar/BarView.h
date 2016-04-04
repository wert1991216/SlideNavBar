//
//  BarView.h
//  HJNavBar
//
//  Created by chen on 16/4/4.
//  Copyright © 2016年 chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BarViewDelegate <NSObject>

- (void)itemDidSelectedWithIndex:(NSInteger)index withCurrentIndex:(NSInteger)currentIndex;

@end
@interface BarView : UIView

@property (nonatomic,weak) id<BarViewDelegate>delegate;

@property (nonatomic, assign)   NSInteger   currentItemIndex;
@property (nonatomic, strong)   NSArray     *itemTitles;

- (id)initWithFrame:(CGRect)frame;


- (void)updateData;
@end
