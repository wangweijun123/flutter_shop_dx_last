# flutter_shop_dx_last

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


D:\>cd work\node_shop_server
D:\work\node_shop_server>npm start


接口
获取首页数据:
http://172.16.64.208:3000/getHomePageContent

获取分类:
http://172.16.64.208:3000/getCategory

爆款
http://172.16.64.208:3000/getHotGoods

分类

guide line: 布局边界

明天购物车


StatefulWidget

StatefulElement  ：：：  An [Element] that uses a [StatefulWidget] as its configuration


StatefulElement(StatefulWidget widget)
: _state = widget.createState()

注意的是只要你调用 setState 就会刷新

通过 Flutter 树机制 解决，例如 Provider；
通过 依赖注入，例如 Get

// 状态管理, 两种方式
// 1 provider
//1 顶层 Provider 组件, 底层provider.of 获取 (树结构)
//provider 也是借助了这样的机制，完成了 View -> Presenter 的获取。
// 通过 Provider.of 获取顶层 Provider 组件中的 Present 对象。
// 显然，所有 Provider 以下的 Widget 节点，都可以通过自身的 context
// 访问到 Provider 中的 Presenter，很好地解决了跨组件的通信问题。

2) 通过依赖注入的方式解决 V → P

树机制很不错，但依赖于 context，这一点有时很让人抓狂。我们知道 Dart 是一种单线程的模型，
所以不存在多线程下对于对象访问的竞态问题。基于此 Get 借助一个全局单例的 Map 存储对象。
通过依赖注入的方式，实现了对 Presenter 层的获取。这样在任意的类中都可以获取到 Presenter。

https://docs.flutter.cn/community/tutorials/state-management-package-getx-provider-analysis/

Provider

依赖树机制，必须基于 context
提供了子组件访问上层的能力
Get

全局单例，任意位置可以存取
存在类型重复，内存回收问题


Get 由于全局单例带来的问题
#
正如前面提到 Get 通过全局单例，默认以 runtimeType 为 key 进行对象的存储，
部分场景可能获取到的对象不符合预期，例如商品详情页之间跳转。由于不同的详情页实例对应
的是同一 Class，即 runtimeType 相同。如果不添加 tag 参数，
在某个页面调用 Get.find 会获取到其它页面已经存储过的对象。同时 Get 中一定要注意考虑到对象的回收，
不然很有可能引起内存泄漏。要么手动在页面 dispose 的时候做 delete 操作，
要么完全使用 Get 中提供的组件，例如 GetBuilder，它会在 dispose 中释放