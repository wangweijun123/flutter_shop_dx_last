import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

// 注意这是 GetMaterialApp
void main() => runApp(GetMaterialApp(home: Home()));

class Controller extends GetxController {
  Controller() {
    print('Controller 构造函数 = ${this.hashCode}');
  }

  var count = 0.obs;
  void increment() {
    count++;
  }
}

class Home extends StatelessWidget {
  // 存放map结构(静态全局)中static final Map<String, _InstanceBuilderFactory> _singl = {};
  // , key is type,
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    print('Home build 放入了controller = ${controller.hashCode}');
    return Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              print('build text controller = ${controller.hashCode}');
              return Text(
                'clicks: ${controller.count}',
              );
            }),
            ElevatedButton(
              child: Text('Next Route'),
              onPressed: () {
                Get.to(Second());
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.increment();
        },
      ),
    );
  }
}

class Second extends StatelessWidget {
  final Controller ctrl = Get.find();
  @override
  Widget build(context) {
    print('Second build get controller = ${ctrl.hashCode}');
    return Scaffold(body: Center(child: Text("${ctrl.count}")));
  }
}
