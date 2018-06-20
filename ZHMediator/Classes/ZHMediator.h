//
//  ZHMediator.h
//  ZHMediator
//
//  Created by xuzhenhao on 2018/6/19.
//

#import <Foundation/Foundation.h>

@interface ZHMediator : NSObject


+ (instancetype)sharedInstance;

/**
 配置默认的执行对象名和方法名(未找到匹配的对象方法时，可用于升级提示页、空白页)

 @param targetName 对象名
 @param actionName 方法名
 */
+ (void)configDefaultTarget:(NSString *)targetName action:(NSString *)actionName;
/**
 本地间组件调用入口

 @param targetName 执行方法的对象名
 @param actionName 要执行的方法名
 @param params 参数
 @param shouldCacheTarget 是否缓存对象
 @return 执行后的返回值
 */
- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params
  shouldCacheTarget:(BOOL)shouldCacheTarget;

/**
 本地间组件调用入口
 
 @param targetName 执行方法的对象名
 @param actionName 要执行的方法名
 @param params 参数
 @return 执行后的返回值
 */
- (id)performTarget:(NSString *)targetName
             action:(NSString *)actionName
             params:(NSDictionary *)params;

/**
 远程schema(URL)调用入口

 @param url URL
 @return 是否成功
 */
+ (BOOL)routeURL:(NSURL *)url;

/**
 添加路由导航规则

 @param schema 路由规则，e.g @"/user/view/:name" :name表示参数，必须和action所需参数的字段名一致
 @param targetName 目标对象
 @param actionName 对象执行的方法名
 @param completion 完成回调
 */
+ (void)addSchema:(NSString *)schema
       targetName:(NSString *)targetName
       actionName:(NSString *)actionName
       completion:(void(^)(id result))completion;

/**
 移除缓存的对象

 @param targetName 对象名
 */
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;


@end
