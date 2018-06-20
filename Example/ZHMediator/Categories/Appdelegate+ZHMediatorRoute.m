//
//  Appdelegate+ZHMediatorRoute.m
//  ZHMediator_Example
//
//  Created by xuzhenhao on 2018/6/20.
//  Copyright © 2018年 632476744@qq.com. All rights reserved.
//

#import "Appdelegate+ZHMediatorRoute.h"
#import <ZHMediator/ZHMediator.h>

@implementation ZHAppDelegate (ZHMediatorRoute)

- (void)zh_configRouter{
    [ZHMediator addSchema:@"/user/view/:name" targetName:@"ZHATarget" actionName:@"AViewController" completion:^(UIViewController *result) {
        if (![result isKindOfClass:[UIViewController class]]) {
            return ;
        }
        UIViewController *vc = [ZHAppDelegate hb_currentDisplayController];
        [vc presentViewController:result animated:YES completion:nil];
    }];
}

#pragma mark - utils
+ (UIViewController *)hb_currentDisplayController{
    //不能直接用keywindow，可能是其他window当前正是keywindow，导致rootvc为空
    UIViewController *rootVC = [[UIApplication sharedApplication] delegate].window.rootViewController;
    if ([rootVC isKindOfClass:[UINavigationController class]]) {
        UINavigationController *nc = (UINavigationController *)rootVC;
        return nc.visibleViewController;
    }
    else if ([rootVC isKindOfClass:[UITabBarController class]]){
        UITabBarController *tabVC = (UITabBarController *)rootVC;
        
        if ([tabVC.selectedViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nc = (UINavigationController *)tabVC.selectedViewController;
            return nc.visibleViewController;
        }
        
        return tabVC.selectedViewController;
    }
    else{
        return rootVC;
    }
}
@end
