import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../log/log_constanst.dart';

void main() => runApp(GetMaterialApp(home: Home()));

class Controller extends GetxController {
  var count = 0.obs;
  void increment() {
    count++;
  }
}

class OtherController extends GetxController {
  OtherController() {
    print('构造OtherController = ${hashCode}'); //  构造OtherController = 204621959
  }
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
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => Text("${ctrl.count}")),
        ElevatedButton(
            onPressed: () {
              ctrl.increment();
            },
            child: Text('增加')),
        ElevatedButton(
            onPressed: () {
              Get.to(ThirdPage());
            },
            child: Text('跳转第三个界面')),
      ],
    )));
  }
}

class ThirdPage extends StatefulWidget {
  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  // 他怎么知道是这个controller, 这些靠谱一点
  final OtherController otherController = Get.put(OtherController());

  @override
  Widget build(context) {
    print('otherController = ${otherController.hashCode}');
    return Scaffold(
        body: Center(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() => Text("${otherController.count}")),
        ElevatedButton(
            onPressed: () {
              otherController.increment();
            },
            child: Text('来自其他otherController 增加')),
      ],
    )));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Get.delete<OtherController>();
  }
}
