import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_dx_last/log/log_constanst.dart';
import 'package:flutter_shop_dx_last/service/http_service.dart';

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("category"));
  }

  //获取分类数据
  void _getCategory() {
    request('getCategory', formData: null).then((val) {
      var data = json.decode(val.toString());
      myPrint("_getCategory = $data");
    });
  }
}
