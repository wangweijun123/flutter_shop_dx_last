import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_shop_dx_last/log/log_constanst.dart';
import 'package:flutter_shop_dx_last/pages/index_page.dart';
import 'package:flutter_shop_dx_last/providers/category_goods_list_provider.dart';
import 'package:flutter_shop_dx_last/providers/category_provider.dart';
import 'package:flutter_shop_dx_last/providers/current_index_provider.dart';
import 'package:provider/provider.dart';
import 'package:easy_refresh/easy_refresh.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  List<int> _data = [];
  int page = -1;
  int pageCount = 25;

  @override
  void initState() {
    super.initState();
    generateNumber();
  }

  generateNumber() {
    page++;
    var list = List.generate(pageCount, (index) => page * pageCount + index);
    print(list);

    setState(() {
      _data.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('购物车'),
        ),
        body: _buildContent(),
      ),
    );
  }

  Text _itemCart(int index) {
    return Text(
      'index = $index',
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }

  _buildContent() {
    return EasyRefresh(
      onRefresh: () async {
        myPrint('onRefresh start....');
        var result = await Future.delayed(const Duration(seconds: 5), () {
          print('One second has passed.'); // Prints after 1 second.
          return "result callback ";
        });
        myPrint('onRefresh end result = $result');
      },
      onLoad: () async {
        myPrint('onLoad ....');
        var result = await Future.delayed(const Duration(seconds: 3), () {
          print('3 second has passed.'); // Prints after 1 second.
          return "onLoad callback ";
        });
        myPrint('onLoad end result = $result');
        generateNumber();
      },
      child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            return _itemCart(index);
          }),
    );
  }
}
