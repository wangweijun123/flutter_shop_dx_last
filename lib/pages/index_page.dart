import 'package:flutter/material.dart';
import 'package:flutter_shop_dx_last/providers/current_index_provider.dart';
import 'package:provider/provider.dart';

import '../config/string.dart';
import 'category_page.dart';
import 'home_page.dart';

/**
 * 只包含四个
 */
class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: KString.homeTitle, //首页
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: KString.categoryTitle, // 分类
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: KString.shoppingCartTitle, //购物车
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: KString.memberTitle, //会员中心
    ),
  ];

  List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CategoryPage(),
    CategoryPage(),
  ];

  //

  @override
  Widget build(BuildContext context) {
    CurrentIndexProvider c1 =
        Provider.of<CurrentIndexProvider>(context, listen: true);
    int currentIndex = c1.currentIndex;
    print("build index = $currentIndex, c1 = ${c1.hashCode}");
    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        items: bottomTabs,
        currentIndex: currentIndex,

        // 加上type底部导航栏才会显示出来
        type: BottomNavigationBarType.fixed,
        onTap: (newIndex) {
          CurrentIndexProvider c2 =
              Provider.of<CurrentIndexProvider>(context, listen: false);
          print("ontab newIndex = $newIndex, c2 = ${c2.hashCode}");
          c2.changeIndex(newIndex);
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
