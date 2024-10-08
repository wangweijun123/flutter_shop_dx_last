import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_dx_last/log/log_constanst.dart';
import 'package:flutter_shop_dx_last/model/category_model.dart';
import 'package:flutter_shop_dx_last/service/http_service.dart';

import '../config/string.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KString.categoryTitle),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: LeftCategoryNav(),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                RightCategoryNav(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List<Data> _data = [];
  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _data.length,
        itemBuilder: (BuildContext context, int index) {
          var bgColor = index == 3 ? Colors.red : Colors.blue;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(_data[index].firstCategoryName),
                height: 60,
                padding: const EdgeInsets.only(left: 4, top: 4),
                color: bgColor,
              ),
              Container(
                height: 1,
                color: Colors.blue,
              )
            ],
          );
        });
  }

  //获取分类数据
  void _getCategory() {
    request('getCategory', formData: null).then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);
      myPrint("_getCategory = ${category.data.length}");
      setState(() {
        _data = category.data;
      });
    });
  }
}

//右侧导航菜单
class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Text("分类");
  }
}
