import 'package:flutter/material.dart';

import '../model/category_goods_list_model.dart';

/// 分类商品列表数据
class CategoryGoodsListProvider with ChangeNotifier {
  List<CategoryListData> goodsList = [];

  getGoodsList(List<CategoryListData> list) {
    goodsList = list;
    notifyListeners();
  }
}
