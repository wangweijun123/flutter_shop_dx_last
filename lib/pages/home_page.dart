import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop_dx_last/log/log_constanst.dart';
import 'package:flutter_shop_dx_last/service/http_service.dart';

import '../config/string.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(KString.homeTitle),
      ),
      body: FutureBuilder(
        future: request('homePageContext', formData: null),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          myPrint("snapshot.hasData = ${snapshot.hasData}");
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            // print(data);
            List<Map> swiperDataList =
                (data['data']['slides'] as List).cast(); //轮播图
            List<Map> navigatorList =
                (data['data']['category'] as List).cast(); //分类
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast(); //商品推荐
            List<Map> floor1 = (data['data']['floor1'] as List).cast(); //底部商品推荐
            Map fp1 = data['data']['floor1Pic']; //广告
            myPrint(
                "swiperDataList  = ${swiperDataList.length}, ${swiperDataList}");

            return ListView(
              children: [
                Text("l1"),
                Text("l2"),
                Text("l3"),
                Text("l4"),
                Text("l5"),
              ],
            );
          } else {
            return Center(child: Text("加载中"));
          }
        },
      ),
    );
  }
}
