import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_dx_last/log/log_constanst.dart';
import 'package:flutter_shop_dx_last/service/http_service.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

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
                SwiperDiy(swiperDataList),
                TopNavigator(navigatorList),
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

/**
 * 轮播图
 */
class SwiperDiy extends StatelessWidget {
  final List<Map> swiperDataList;
  SwiperDiy(this.swiperDataList);

  @override
  Widget build(BuildContext context) {
    // Swiper 外部必须加上父亲Container 控制宽高
    return Container(
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(333),
      child: Swiper(
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            "${swiperDataList[index]['image']}",
            fit: BoxFit.cover,
          );
        },
        itemCount: swiperDataList.length,
        pagination: const SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List<Map> navigatorList;
  const TopNavigator(this.navigatorList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(250),
      child: GridView.count(
        crossAxisCount: 5,
        children: navigatorList.map((item) {
          return _gridViewItemUI(item);
        }).toList(),
      ),
    );
  }

  Widget _gridViewItemUI(Map<dynamic, dynamic> item) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          "${item['image']}",
          fit: BoxFit.cover,
          width: ScreenUtil().setWidth(95),
        ),
        Text(item['firstCategoryName'])
      ],
    );
  }
}
