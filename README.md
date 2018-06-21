# ZHMediator

[![CI Status](https://img.shields.io/travis/632476744@qq.com/ZHMediator.svg?style=flat)](https://travis-ci.org/632476744@qq.com/ZHMediator)
[![Version](https://img.shields.io/cocoapods/v/ZHMediator.svg?style=flat)](https://cocoapods.org/pods/ZHMediator)
[![License](https://img.shields.io/cocoapods/l/ZHMediator.svg?style=flat)](https://cocoapods.org/pods/ZHMediator)
[![Platform](https://img.shields.io/cocoapods/p/ZHMediator.svg?style=flat)](https://cocoapods.org/pods/ZHMediator)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

>=iOS 8.2

## Installation

ZHMediator is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZHMediator'
```

## Description

一. 总述

这个方案的最终目的很明确，就是要抽象出一个中间层来对纷乱的引用关系进行统一的跳转。模块只和中间层耦合，模块间解耦；中间层使用runtime的形式调用模块的业务组件，不依赖具体的模块代码.

二. 业务场景

脱离业务需求的设计都是空中楼阁，下面将结合具体的业务场景进行方案分析和设计。

下面是大多数app都会遇到的业务场景:
- 启动开屏广告是个运营位置，需要任意跳转
- 轮播图是个运营位置，需要任意跳转
- webview中通过bridge，也存在任意跳转原生的可能性
- 模块间各种push

简单粗暴的方法，就是switch判断类型，引入各种头文件，直接跳转。随着业务膨胀，以下弊端会越来越明显：
- 没有统一的跳转管理，每块业务都维护了自身的一套逻辑，使得跳转逻辑四处散落;
- 如果要新增一种跳转类型，如1所述，必须要找到四处的跳转逻辑，把可能的地方都加一遍，维护起来非常费劲；
- 模块间文件直接引用，耦合严重。如果修改删除了某个模块间的某个文件，会直接影响到所有引用了他的文件；理想期望是独立模块可以编译运行，每个模块可随意插拔;
- 模块间的耦合导致模块无法复用；理想期望是一个模块复制到新项目时，可以直接编译运行;

三.梳理分析

通过上述业务场景，最直观的痛点的跳转管理问题，但本质上都是耦合的问题，是文件间的引用耦合。
要调用一个类的方法，import相关的头文件，再根据头文件暴露的api进行调用，这再正常不过了。当业务膨胀后，模块内可以直接耦合引用，但模块间就必须想办法解耦。
目前业内有两种主流方案:
1. 以JLRoutes为代表的URLRoute方案:以URL为key，以待执行的block为value，保存在一个全局map中，在内存中常驻;
2. Mediator中间人方案:把所有的调用都集合在一起，使用一个中间人管理。所有调用方都通过中间人调取另外一个模块;

这两种方案单独来说都有各自的优劣势:
- URLRoute方案借鉴了web的思路，非常契合远程调用这种场景。但是在开发时本地原生调用时，使用者会感到变扭。我们更习惯调方法，给方法赋值。在使用URLRoute时，我们还需要多一步转换逻辑，将方法调用转换成URL形式。这既不方便，同样存在漏洞。因为URL中只能携带常规数据，无法把类似UIImage等格式的数据封装在URL中。
- Mediator方案相比起来对原生调用就非常友好，但当遇见app://user/:userName这样的跳转需求时，就显得不那么契合。
详情的分析可以参考https://casatwy.com/iOS-Modulization.html.

四. 结合URLRoute和Mediator的跳转方案

分析到这里，其实最后的方案已经呼之欲出了。我们即想要URLRoute这种完美契合schema模型的远程调用体验，也想要Mediator本地方法调用的体验。![1.png](https://user-gold-cdn.xitu.io/2018/6/21/164202d0edf8e7b9?w=878&h=1174&f=png&s=13648)

方案如图所示，具体demo在https://github.com/xuzhenhao/ZHMediator。下面将结合组件化的思路一起阐述整个方案如何落地。

1. 模块化拆分。
- 首先要进行模块的划分，只有模块间的调用才会考虑这种方式，模块内的调用是允许相互间耦合的，因此合理的模块划分就很重要。
- 暴露Target对象。Target对象暴露整个模块对外提供的所有服务，此外，因为Mediator和Target是通过Runtime交互的，Target暴露的方法中接收的参数是一个字典，但在方法实现中负责将传过来的字典还原成各个参数，并调用该模块具体的类和方法。
- 编写模块的Mediator分类。如上所述，受限于runtime只能以字典形式传一系列参数，Mediator分类的职责就在于对外提供参数友好型的一系列方法，但在方法实现中包装成字典形式。这里涉及到key的定义必须和Target中还原时的key定义一致，因此划分给相同的开发维护。
2. 远程调用

- 配置URL解析规则。类似app://user/:userId/detail 这样的URL，需要通过解析规则，解析出TargetName、ActionName、Params，交付给Mediator进行处理。目前只是简单基于JLRoutes的二次封装，当然这里可以根据需求，后续也能方便替换。这部分配置建议统一放在AppDelegete+Routes的分类中统一配置。

至此，核心部分就介绍完毕了。完整的demo可以在https://github.com/xuzhenhao/ZHMediator获得。


## Author

xuzhenhao  632476744@qq.com

## License

ZHMediator is available under the MIT license. See the LICENSE file for more info.
