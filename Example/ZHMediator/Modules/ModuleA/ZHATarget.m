//
//  ZHATarget.m
//  ZHMediator_Example
//
//  Created by xuzhenhao on 2018/6/19.
//  Copyright © 2018年 632476744@qq.com. All rights reserved.
//

#import "ZHATarget.h"
#import "ZHAViewController.h"

@implementation ZHATarget

- (UIViewController *)AViewControllerWithParams:(NSDictionary *)params{
    NSString *title = params[@"title"];
    ZHAViewController *vc = [ZHAViewController new];
    vc.titleString = title;
    return vc;
}
@end
