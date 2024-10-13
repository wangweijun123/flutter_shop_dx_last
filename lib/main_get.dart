import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

void main() => runApp(MaterialApp(home: Home()));

class Home extends StatelessWidget {
  var count = 0.obs;
  @override
  Widget build(context) {
    print("Home build ...");
    return Scaffold(
        appBar: AppBar(title: Text("counter")),
        body: Center(
          child: Obx(() {
            print("rebuild Text ..."); // 从element.rebuild()调用
            return Text("$count");
          }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print("click ...");
            count++;
          },
        ));
  }
}
