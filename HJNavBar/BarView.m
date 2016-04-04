//
//  BarView.m
//  HJNavBar
//
//  Created by chen on 16/4/4.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "BarView.h"

#define SCREENW  ([UIScreen mainScreen].bounds.size.width)
#define SCREENH  ([UIScreen mainScreen].bounds.size.height)
@implementation BarView{
     UIScrollView    *_navgationTabBar;
     NSArray         *_itemsWidth;
    NSMutableArray  *_items; //按钮元素
    UIView          *_line;
    
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    
        // self.backgroundColor = [UIColor clearColor];
         _items = [@[] mutableCopy];
        [self viewConfig];

    }
    return self;
}



- (void)viewConfig
{
    
#pragma mark  scrollview
    _navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, SCREENW , 44)];
    _navgationTabBar.backgroundColor = [UIColor clearColor];
    _navgationTabBar.showsHorizontalScrollIndicator = NO;
    [self addSubview:_navgationTabBar];
    
}

- (void)updateData
{
    
    _itemsWidth = [self getButtonsWidthWithTitles:_itemTitles];
    if (_itemsWidth.count)
    {
        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navgationTabBar.contentSize = CGSizeMake(contentWidth, 0);
    }
}




- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    CGFloat buttonX = 0;
    
    for (NSInteger index = 0; index < [_itemTitles count]; index++)
    {
        
#pragma mark  设置字体
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        CGSize textMaxSize = CGSizeMake(SCREENW, MAXFLOAT);
        CGSize textRealSize = [self sizeWithFont:[UIFont systemFontOfSize:14.0f] maxSize:textMaxSize withString:_itemTitles[index]];
        
        textRealSize = CGSizeMake(textRealSize.width + 15*2, 44);
        button.frame = CGRectMake(buttonX, 0,textRealSize.width, 44);
        
        //字体颜色
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(itemPressed:type:) forControlEvents:UIControlEventTouchUpInside];
        [_navgationTabBar addSubview:button];
        [_items addObject:button];
        buttonX += button.frame.size.width;
       
    }
    
    [self showLineWithButtonWidth:[widths[0] floatValue]];
    return buttonX;
}


#pragma mark  下划线
- (void)showLineWithButtonWidth:(CGFloat)width
{
    //第一个线的位置
    _line = [[UIView alloc] initWithFrame:CGRectMake(15 - 2.0f, 45 - 2.0f, width, 2.0f)];
    _line.backgroundColor = [UIColor redColor];
    [_navgationTabBar addSubview:_line];
    
    UIButton *btn = _items[0];
    [self itemPressed:btn type:0];
    //    btn.selected = YES;
    //    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
}


- (void)itemPressed:(UIButton *)button type:(int)type
{

    [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    
    //    if (type == 0) {
    NSInteger index = [_items indexOfObject:button];
    [_delegate itemDidSelectedWithIndex:index withCurrentIndex:_currentItemIndex];
    //    }
}




//计算数组内字体的宽度
- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    
    for (NSString *title in titles)
    {
        CGSize textMaxSize = CGSizeMake(SCREENW, MAXFLOAT);
        CGSize textRealSize = [self sizeWithFont:[UIFont systemFontOfSize:12.0f] maxSize:textMaxSize withString:title];
        
        NSNumber *width = [NSNumber numberWithFloat:textRealSize.width];
        [widths addObject:width];
    }
    
    return widths;
}






#pragma mark 偏移
- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    _currentItemIndex = currentItemIndex;
    UIButton *button = _items[currentItemIndex];
    
    
    CGFloat flag = SCREENW ;
    
    if (button.frame.origin.x + button.frame.size.width + 50 >= flag)
    {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width - flag;
        if (_currentItemIndex < [_itemTitles count]-1)
        {
            offsetX = offsetX + button.frame.size.width;
        }
        [_navgationTabBar setContentOffset:CGPointMake(offsetX, 0) animated:YES];
        
    }
    else
    {
        [_navgationTabBar setContentOffset:CGPointMake(0, 0) animated:YES];
    }
    //下划线的偏移量
    [UIView animateWithDuration:0.1f animations:^{
        _line.frame = CGRectMake(button.frame.origin.x + 15, _line.frame.origin.y, [_itemsWidth[currentItemIndex] floatValue], _line.frame.size.height);
    }];
    //    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    //
    //    UIButton *btn1 = _items[currentItemIndex-1];
    //    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}


#pragma mark 宽度计算
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize withString:(NSString*)str
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
