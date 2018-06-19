//
//  ZHMediator+ZHModuleAActions.m
//  ZHMediator_Example
//
//  Created by xuzhenhao on 2018/6/19.
//  Copyright © 2018年 632476744@qq.com. All rights reserved.
//

#import "ZHMediator+ZHModuleAActions.h"

NSString * const kZHMediatorTargetA = @"ZHATarget";

@implementation ZHMediator (ZHModuleAActions)

- (UIViewController *)AViewControllerWithTitle:(NSString *)title{
    UIViewController *vc = [self performTarget:kZHMediatorTargetA action:@"AViewController" params:@{@"title":title}];
    if ([vc isKindOfClass:[UIViewController class]]) {
        return vc;
    }else{
        return [UIViewController new];
    }
}
@end
