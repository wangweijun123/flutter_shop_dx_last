import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_dx_last/log/log_constanst.dart';
import 'package:flutter_shop_dx_last/service/http_service.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

import '../config/color.dart';
import '../config/font.dart';
import '../config/string.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _getHotGoods();
  }

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
            Map fp1 = data['data']['floor1Pic']; //广告

            List<Map> floor1 = (data['data']['floor1'] as List).cast(); //底部商品推荐

            // myPrint(
            //     "recommendList  = ${recommendList.length}, ${recommendList}");

            return ListView(
              children: [
                SwiperDiy(swiperDataList),
                TopNavigator(navigatorList),
                RecommendUI(recommendList),
                Container(
                  height: 10,
                  color: Colors.grey,
                ),
                FloorPic(fp1),
                Floor(floor1),
                _wrapList(),
              ],
            );
          } else {
            return Center(child: Text("加载中"));
          }
        },
      ),
    );
  }

//火爆专区分页
  int page = 1;
  //火爆专区数据
  List<Map> hotGoodsList = [];
  void _getHotGoods() {
    var formPage = {'page': page};
    request('getHotGoods', formData: formPage).then((val) {
      var data = json.decode(val.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      //设置火爆专区数据列表
      setState(() {
        hotGoodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  Widget _wrapList() {
    if (hotGoodsList.isNotEmpty) {
      // 默认横向的流式布局, spacing 横向空间的大小, runSpaciing纵向大小
      return Wrap(
        spacing: 2,
        children: generateChildren(),
        runSpacing: 10,
      );
    } else {
      return Text('加载中 ...');
    }
  }

  List<Widget> generateChildren() {
    return hotGoodsList.map((Map item) {
      double imageWidth = 194;
      double imageHeight = 210;
      return Container(
        width: imageWidth,
        child: Column(
          children: [
            Image.network(
              item['image'],
              width: imageWidth,
              height: imageHeight,
              fit: BoxFit.cover,
            ),
            Text(
              item['name'],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: ScreenUtil().setSp(26)),
            ),
            Row(
              children: <Widget>[
                Text(
                  '￥${item['presentPrice']}',
                  style: TextStyle(color: KColor.presentPriceTextColor),
                ),
                Text(
                  '￥${item['oriPrice']}',
                  style: TextStyle(color: KColor.oriPriceColor),
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
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

class RecommendUI extends StatelessWidget {
  final List<Map> recommendList;

  const RecommendUI(this.recommendList, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 10,
          color: Colors.grey,
        ),
        Text(
          KString.recommendText, //'商品推荐',
          style: TextStyle(color: KColor.homeSubTitleTextColor),
        ),
        Container(
          height: 1,
          color: Colors.red,
          margin: const EdgeInsets.only(top: 6),
        ),
        Container(
          // 因为本身处于listview中(可滑动组件,所以必须指定高度)
          height: ScreenUtil().setHeight(295),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: recommendList.length,
              itemBuilder: (BuildContext context, int index) {
                return _item(recommendList[index]);
              }),
        ),
      ],
    );
  }

  Widget _item(Map<dynamic, dynamic> map) {
    return Row(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Image.network(
                map['image'],
                width: ScreenUtil().setHeight(200),
                height: ScreenUtil().setHeight(200),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                '￥${map['presentPrice']}',
                style: TextStyle(color: KColor.presentPriceTextColor),
              ),
            ),
            Text(
              '￥${map['oriPrice']}',
              style: KFont.oriPriceStyle,
            ),
          ],
        ),
        Container(
          height: ScreenUtil().setHeight(295),
          width: 1,
          color: Colors.red,
        )
      ],
    );
  }
}

//商品推荐中间广告
class FloorPic extends StatelessWidget {
  final Map floorPic;

  const FloorPic(this.floorPic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(floorPic['PICTURE_ADDRESS']);
  }
}

//商品推荐下层
class Floor extends StatelessWidget {
  final List<Map> floor;
  const Floor(this.floor);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Image.network(
                floor[0]['image'],
                fit: BoxFit.fitWidth,
              ),
              Image.network(
                floor[1]['image'],
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
        Expanded(
          // 这个相当于weight
          flex: 1,
          child: Column(
            children: [
              Image.network(floor[2]['image']),
              const SizedBox(
                height: 5,
              ),
              Image.network(floor[3]['image']),
              const SizedBox(
                height: 5,
              ),
              Image.network(floor[4]['image']),
            ],
          ),
        ),
      ],
    );
  }
}
