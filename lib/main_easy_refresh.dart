import 'package:flutter/material.dart';
import 'package:flutter_shop_dx_last/pages/index_page.dart';
import 'package:flutter_shop_dx_last/providers/category_goods_list_provider.dart';
import 'package:flutter_shop_dx_last/providers/category_provider.dart';
import 'package:flutter_shop_dx_last/providers/current_index_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('购物车'),
        ),
        body: ListView.builder(
            itemCount: 50,
            itemBuilder: (BuildContext context, int index) {
              return _itemCart(index);
            }),
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
}
