import 'package:flutter/material.dart';
import 'package:flutter_shop_dx_last/log/log_constanst.dart';
import 'package:flutter_shop_dx_last/model/category_model.dart';

class CategoryProvider with ChangeNotifier {
  List<SecondCategoryVO> secondCategoryList = []; // 二级分类

  int firstCategoryIndex = 0; //一级分类索引
  String firstCategoryId = '4'; //一级ID

  int secondCategoryIndex = 0; //二级分类索引选中
  String secondCategoryId = '';

  //首页点击类别时更改类别
  changeFirstCategory(String firstCategoryId, int firstCategoryIndex) {
    this.firstCategoryId = firstCategoryId;
    this.firstCategoryIndex = firstCategoryIndex;
    notifyListeners();
  }

  /// 保存二级分类
  void setSecondCategory(int secondCategoryIndex,
      List<SecondCategoryVO> secondCategoryList, String firstCategoryId) {
    this.secondCategoryList = secondCategoryList;
    this.firstCategoryId = firstCategoryId;

    this.secondCategoryIndex = secondCategoryIndex;
    secondCategoryId = secondCategoryList[secondCategoryIndex].secondCategoryId;
    myPrint('update secondCategoryIndex to xx 0');
    // 一定要记得notify
    notifyListeners();
  }

  //改变二类索引
  void changeSecondIndex(int secondCategoryIndex, String id) {
    this.secondCategoryIndex = secondCategoryIndex;
    this.secondCategoryId = id;
    notifyListeners();
  }
}
