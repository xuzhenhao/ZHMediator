//
//  ZHMediator+ZHModuleAActions.h
//  ZHMediator_Example
//
//  Created by xuzhenhao on 2018/6/19.
//  Copyright © 2018年 632476744@qq.com. All rights reserved.
//

/*
 1.通过对应模块的Category调用模块内的服务
 2.Category对外暴露了参数友好的调用，避免了字典类型的参数调用
 3.模块的Category和模块都由模块开发者提供维护，在Categegory实现中，会涉及到各个参数封装成字典，字段名是硬编码的，必须和模块内Target解析的保持一致。
*/


#import "ZHMediator.h"

@interface ZHMediator (ZHModuleAActions)

- (UIViewController *)AViewControllerWithTitle:(NSString *)title;

@end
