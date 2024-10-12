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
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
          ChangeNotifierProvider(create: (_) => CategoryProvider()),
          ChangeNotifierProvider(create: (_) => CategoryGoodsListProvider()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: IndexPage(),
        ));
  }
}
