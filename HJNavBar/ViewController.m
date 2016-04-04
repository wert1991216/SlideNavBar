//
//  ViewController.m
//  HJNavBar
//
//  Created by chen on 16/4/4.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "ViewController.h"
#import "BarView.h"
#import "SubvieViewController.h"

#define SCREENW  ([UIScreen mainScreen].bounds.size.width)
#define SCREENH  ([UIScreen mainScreen].bounds.size.height)
@interface ViewController ()<BarViewDelegate,UIScrollViewDelegate>{
    NSInteger       _currentIndex;
    UIScrollView    *_mainView;
    BarView    *_navTabBar;
    NSMutableArray  *_titles;
    NSMutableArray *_SubvcArrs;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _titles = @[@"国内",@"国际",@"娱乐",@"体育",@"科技",@"奇闻趣事",@"生活健康"];
    
    _SubvcArrs = [NSMutableArray array];
    

    for(int i = 0; i < _titles.count; i++)
    {
        SubvieViewController *SubVC = [[SubvieViewController alloc] init];
        SubVC.title = _titles[i];
        SubVC.content= _titles[i];
        [_SubvcArrs addObject:SubVC];
    }
    
    //注册bar
    [self viewInit];
    
    //首先加载第一个视图
    UIViewController *viewController = (UIViewController *)_SubvcArrs[0];
    viewController.view.frame = CGRectMake(0 , 0, SCREENW, SCREENH);
    [_mainView addSubview:viewController.view];
    [self addChildViewController:viewController];
    
    
}


- (void)viewInit
{
    
    _navTabBar = [[BarView alloc] initWithFrame:CGRectMake(0, 0, SCREENW , 64)];
    _navTabBar.backgroundColor = [UIColor colorWithRed:246/255.0f green:246/255.0f blue:247/255.0f alpha:1];
    _navTabBar.delegate = self;
    _navTabBar.itemTitles = _titles;
    [_navTabBar updateData];
    [self.view addSubview:_navTabBar];
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREENW , SCREENH - 64)];
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.showsVerticalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(SCREENW * _SubvcArrs.count, 0);
    [self.view addSubview:_mainView];
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREENW, 1)];
    linev.backgroundColor = [UIColor colorWithRed:216/255.0f green:216/255.0f blue:216/255.0f alpha:1];
    [self.view addSubview:linev];
    

    
}


#pragma mark - Scroll View Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentIndex = scrollView.contentOffset.x / SCREENW;
    _navTabBar.currentItemIndex = _currentIndex;
    
    /** 当scrollview滚动的时候加载当前视图 */
    UIViewController *viewController = (UIViewController *)_SubvcArrs[_currentIndex];
    viewController.view.frame = CGRectMake(_currentIndex * SCREENW, 0, SCREENW, _mainView.frame.size.height);
    [_mainView addSubview:viewController.view];
    [self addChildViewController:viewController];
    
}




- (void)itemDidSelectedWithIndex:(NSInteger)index withCurrentIndex:(NSInteger)currentIndex
{
    if (currentIndex-index>=2 || currentIndex-index<=-2) {
        
        [_mainView setContentOffset:CGPointMake(index * SCREENW, 0) animated:NO];
        
    }else{
        
        [_mainView setContentOffset:CGPointMake(index * SCREENW, 0) animated:YES];
    }
    
    //    NSString *str = [NSString stringWithFormat:@"%d",index];
    //    [[NSNotificationCenter defaultCenter]postNotificationName:@"偏移" object:str];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
