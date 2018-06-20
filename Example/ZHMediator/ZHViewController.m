//
//  ZHViewController.m
//  ZHMediator
//
//  Created by 632476744@qq.com on 06/19/2018.
//  Copyright (c) 2018 632476744@qq.com. All rights reserved.
//

#import "ZHViewController.h"
#import "ZHMediator+ZHModuleAActions.h"
#import <ZHMediator/ZHMediator.h>

@interface ZHViewController ()

@end

@implementation ZHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //远程调用及本地调用
    BOOL isRemoteCall = YES;
    if (isRemoteCall) {
        [self remoteCall];
    }else{
        [self nativecall];
    }
}
- (void)remoteCall{
    NSURL *remoteURL = [NSURL URLWithString:@"ky://user/view/xuzhenhao"];
    [ZHMediator routeURL:remoteURL];
}
- (void)nativecall{
    //每个Category对应一个模块，包括了该模块的所有服务，其他模块通过Category调用。
    UIViewController *vc = [[ZHMediator sharedInstance] AViewControllerWithTitle:@"ModuleA"] ;
    [self presentViewController:vc animated:YES completion:nil];
}
@end
