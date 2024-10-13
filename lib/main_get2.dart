import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'log/log_constanst.dart';

void main() => runApp(GetMaterialApp(home: Home()));

class Controller extends GetxController {
  var count = 0.obs;
  void increment() {
    count++;
  }
}

class Home extends StatelessWidget {
  final controller = Get.put(Controller());
  @override
  Widget build(BuildContext context) {
    myPrint(' Home build ....');
    return Scaffold(
      appBar: AppBar(title: Text("counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() => Text(
                  'clicks: ${controller.count}',
                )),
            ElevatedButton(
              child: Text('Next Route'),
              onPressed: () {
                myPrint('go to ...');
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
          }),
    );
  }
}

class Second extends StatelessWidget {
  // 他怎么知道是这个controller, 这些靠谱一点
  final Controller ctrl = Get.find<Controller>();
  @override
  Widget build(context) {
    // todo 在第二个界面修改, 作用到第一个界面
    return Scaffold(body: Center(child: Text("${ctrl.count}")));
  }
}
