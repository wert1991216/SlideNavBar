//
//  SubvieViewController.m
//  HJNavBar
//
//  Created by chen on 16/4/4.
//  Copyright © 2016年 chen. All rights reserved.
//

#import "SubvieViewController.h"

@interface SubvieViewController ()

@end

@implementation SubvieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTestLabel:(UILabel *)TestLabel{
    TestLabel.text = _content;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
