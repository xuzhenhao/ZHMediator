//
//  ZHAViewController.m
//  ZHMediator_Example
//
//  Created by xuzhenhao on 2018/6/19.
//  Copyright © 2018年 632476744@qq.com. All rights reserved.
//

#import "ZHAViewController.h"

@interface ZHAViewController ()

@end

@implementation ZHAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"%@",self.titleString);
}

@end
