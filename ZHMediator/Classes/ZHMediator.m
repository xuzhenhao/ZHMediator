//
//  ZHMediator.m
//  ZHMediator
//
//  Created by xuzhenhao on 2018/6/19.
//

#import "ZHMediator.h"

@interface ZHMediator ()

/** 缓存的对象*/
@property (nonatomic, strong)   NSMutableDictionary     *cachedTarget;
/** 默认执行的对象名*/
@property (nonatomic, copy)     NSString    *defaultTargetName;
/** 默认执行的方法名*/
@property (nonatomic, copy)     NSString    *defaultActionName;

@end

@implementation ZHMediator

#pragma mark - public method
+ (instancetype)sharedInstance{
    static ZHMediator *mediator;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mediator = [[ZHMediator alloc] init];
    });
    
    return mediator;
}
+ (void)configDefaultTarget:(NSString *)targetName action:(NSString *)actionName{
    ZHMediator *mediator = [self sharedInstance];
    mediator.defaultTargetName = targetName;
    mediator.defaultActionName = actionName;
}
- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params
  shouldCacheTarget:(BOOL)shouldCacheTarget{
    
    //获取执行对象
    Class targetClass = nil;
    //先从缓存中查找
    NSObject *target = self.cachedTarget[targetName];
    if (!target) {
        targetClass = NSClassFromString(targetName);
        target = [[targetClass alloc] init];
    }
    if (!target) {
        [self performDefaultTargetAction];
        return nil;
    }
    if (shouldCacheTarget) {
        self.cachedTarget[targetName] = target;
    }
    
    //获取待执行的方法
    NSString *actionString = actionName;
    if (params) {
        actionString = [NSString stringWithFormat:@"%@:",actionName];
    }
    SEL action = NSSelectorFromString(actionString);
    
    //尝试执行
    if ([target respondsToSelector:action]) {
        return [self safePerformAction:action target:target params:params];
    }else{
        //再次尝试
        actionString = [NSString stringWithFormat:@"%@WithParams:",actionName];
        action = NSSelectorFromString(actionString);
        if ([target respondsToSelector:action]) {
            return [self safePerformAction:action target:target params:params];
        }else{
            //未找到匹配的，执行默认的对象方法
            [self performDefaultTargetAction];
            [self.cachedTarget removeObjectForKey:targetName];
            return nil;
        }
    }
    
}
- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params{
    return [self performTarget:targetName action:actionName params:params shouldCacheTarget:NO];
}
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName{
    [self.cachedTarget removeObjectForKey:targetName];
}
#pragma mark - private method
- (id)safePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params{
    
    NSMethodSignature *methodSig = [target methodSignatureForSelector:action];
    if (!methodSig) {
        return nil;
    }
    //根据方法返回值类型处理不同的返回值情况
    const char* retType = [methodSig methodReturnType];
    //返回值为void
    if (strcmp(retType, @encode(void)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        return nil;
    }
    //返回值为NSInteger
    if (strcmp(retType, @encode(NSInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    //返回值为BOOL
    if (strcmp(retType, @encode(BOOL)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        BOOL result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    //返回值为CGFloat
    if (strcmp(retType, @encode(CGFloat)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        CGFloat result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    //返回值为NSUInteger
    if (strcmp(retType, @encode(NSUInteger)) == 0) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
        [invocation setArgument:&params atIndex:2];
        [invocation setSelector:action];
        [invocation setTarget:target];
        [invocation invoke];
        NSUInteger result = 0;
        [invocation getReturnValue:&result];
        return @(result);
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

/**执行默认的对象方法，提示出错或提示升级等*/
- (void)performDefaultTargetAction{
    if (!self.defaultActionName || !self.defaultTargetName) {
        return;
    }
    
    SEL action = NSSelectorFromString([NSString stringWithFormat:@"%@:",self.defaultActionName]);
    NSObject *target = [[NSClassFromString(self.defaultTargetName) alloc] init];
    [self safePerformAction:action target:target params:nil];
}

#pragma mark - getter&setter
- (NSMutableDictionary *)cachedTarget{
    if(!_cachedTarget){
        _cachedTarget = [NSMutableDictionary dictionary];
    }
    return _cachedTarget;
}

@end
