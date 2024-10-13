import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop_dx_last/log/log_constanst.dart';
import 'package:flutter_shop_dx_last/model/category_model.dart';
import 'package:flutter_shop_dx_last/service/http_service.dart';
import 'package:provider/provider.dart';

import '../config/color.dart';
import '../config/font.dart';
import '../config/string.dart';
import '../model/category_goods_list_model.dart';
import '../providers/category_goods_list_provider.dart';
import '../providers/category_provider.dart';

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
          LeftCategoryNav(),
          Container(
            // 为什么需要搞死, 还是flutter适配问题
            width: ScreenUtil().setWidth(4),
            height: ScreenUtil().setHeight(1334),
            color: Colors.blue,
          ),
          Column(
            children: [RightCategoryNav(), CategoryGoodsList()],
          )
          // Expanded(
          //   flex: 1,
          //   child: ,
          // ),
          // Expanded(
          //   flex: 3,
          //   child: ,
          // ),
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
  var listIndex = 0; //一级索引

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryProvider>(context, listen: true);
    listIndex = categoryProvider.firstCategoryIndex;
    myPrint('_LeftCategoryNavState  listIndex= $listIndex');
    return Container(
      width: ScreenUtil().setWidth(176),
      child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            return _leftInkWel(index);
          }),
    );
  }

  Widget _leftInkWel(int index) {
    var bgColor = index == listIndex ? Colors.red : Colors.blue;
    return InkWell(
      onTap: () {
        var firstCategoryId = _data[index].firstCategoryId;
        var secondCategoryList = _data[index].secondCategoryVO;
        var categoryProvider =
            Provider.of<CategoryProvider>(context, listen: false);
        categoryProvider.changeFirstCategory(firstCategoryId, index);
        categoryProvider.setSecondCategory(
            0, secondCategoryList, firstCategoryId);
        _getGoodList(context, firstCategoryId: firstCategoryId);
      },
      child: Column(
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
      ),
    );
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

      // 保存二级分类
      var categoryProvider =
          Provider.of<CategoryProvider>(context, listen: false);
      myPrint(
          'LeftCategoryNav categoryProvider = ${categoryProvider.hashCode}');
      categoryProvider.setSecondCategory(
          0, _data[0].secondCategoryVO, _data[0].firstCategoryId);
      myPrint(
          'listIndex = $listIndex, _data[0].secondCategoryVO = ${_data[listIndex].secondCategoryVO.length}');
      _getGoodList(context, firstCategoryId: _data[0].firstCategoryId);
    });
  }

  _getGoodList(context, {required String firstCategoryId}) {
    var requestData = {
      'firstCategoryId': firstCategoryId == null
          ? Provider.of<CategoryProvider>(context, listen: false)
              .firstCategoryId
          : firstCategoryId,
      'secondCategoryId': Provider.of<CategoryProvider>(context, listen: false)
          .secondCategoryId,
      'page': 1
    };
    myPrint(' getCategoryGoods request data = $requestData');
    request('getCategoryGoods', formData: requestData).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);

      var result = goodsList.data;
      myPrint('request  getCategoryGoods before result= $result');
      // todo firstCategoryId: 2, secondCategoryId: 21
      // if (requestData['firstCategoryId'] == "2") {
      //   result = goodsList.data.reversed.toList();
      // }
      // myPrint('request getCategoryGoods after result= $result');
      Provider.of<CategoryGoodsListProvider>(context, listen: false)
          .saveGoodsList(result);
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
    var categoryProvider = Provider.of<CategoryProvider>(context, listen: true);
    var lenght = categoryProvider.secondCategoryList.length;
    myPrint(
        'RightCategoryNav categoryProvider = ${categoryProvider.hashCode}, lenght = $lenght');
    if (lenght == 0) {
      return Text("二级分类长度 = ${lenght}");
    } else {
      var secondCategoryIndex = categoryProvider.secondCategoryIndex;
      myPrint('RightCategoryNav secondCategoryIndex = $secondCategoryIndex');
      // 看最上面的log
      return Container(
        // child 是横向的listview, 必须给出高度, 还有必须指出宽度
        height: ScreenUtil().setHeight(80),
        width: ScreenUtil().setWidth(570),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: lenght,
            itemBuilder: (BuildContext context, int index) {
              return _rightInkWel(
                  index,
                  categoryProvider.secondCategoryList[index],
                  secondCategoryIndex);
            }),
      );
    }

    /*return Consumer<CategoryProvider>(builder: (
      BuildContext context,
      CategoryProvider categoryProvider,
      Widget? child,
    ) {
      var lenght = categoryProvider.secondCategoryList.length;
      myPrint(
          'RightCategoryNav categoryProvider = ${categoryProvider.hashCode}, lenght = $lenght');
      return Text("二级分类长度 = ${lenght}");
    });*/
  }

  Widget _rightInkWel(
      int index, SecondCategoryVO item, int secondCategoryIndex) {
    return InkWell(
      onTap: () {
        var provider = Provider.of<CategoryProvider>(context, listen: false);
        provider.changeSecondIndex(
            index, item.secondCategoryId); //categoryProvider.secondCategoryList
        _getGoodList(context, firstCategoryId: provider.firstCategoryId);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          item.secondCategoryName,
          style: TextStyle(
              color: secondCategoryIndex == index ? Colors.red : Colors.black),
        ),
      ),
    );
  }

  _getGoodList(context, {required String firstCategoryId}) {
    var data = {
      'firstCategoryId': firstCategoryId == null
          ? Provider.of<CategoryProvider>(context, listen: false)
              .firstCategoryId
          : firstCategoryId,
      'secondCategoryId': Provider.of<CategoryProvider>(context, listen: false)
          .secondCategoryId,
      'page': 1
    };
    myPrint(' getCategoryGoods request data = $data');
    request('getCategoryGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      myPrint('request getCategoryGoods result= ${goodsList.data.length}');
      Provider.of<CategoryGoodsListProvider>(context, listen: false)
          .saveGoodsList(goodsList.data);
    });
  }
}

class CategoryGoodsList extends StatefulWidget {
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  Widget build(BuildContext context) {
    var categoryGoodsListProvider =
        Provider.of<CategoryGoodsListProvider>(context, listen: true);
    var length = categoryGoodsListProvider.goodsList.length;
    myPrint('_CategoryGoodsListState build length = $length');
    return Expanded(
      // Vertical viewport was given unbounded height.
      child: Container(
        width: ScreenUtil()
            .setWidth(570), // Vertical viewport was given unbounded width.
        child: ListView.builder(
            itemCount: categoryGoodsListProvider.goodsList.length,
            itemBuilder: (BuildContext context, int index) {
              CategoryListData categoryListData =
                  categoryGoodsListProvider.goodsList[index];
              return Column(
                children: [
                  Container(
                    height: 1,
                    color: Colors.blue,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                    child: Row(
                      children: [
                        Image.network(
                          categoryListData.image,
                          width: 100,
                          height: 100,
                        ),
                        Container(
                          // 为什么一定需要限制文本的宽度,它不知道系统所剩下的宽度吗？？？
                          width: ScreenUtil().setWidth(370),
                          child: Column(
                            children: [
                              Text(categoryListData.name,
                                  maxLines: 2, overflow: TextOverflow.ellipsis),
                              Padding(
                                padding: const EdgeInsets.only(top: 12),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      '价格:￥${categoryListData.presentPrice}',
                                      style: TextStyle(
                                          color: KColor.presentPriceTextColor),
                                    ),
                                    Text(
                                      '￥${categoryListData.oriPrice}',
                                      style: KFont.oriPriceStyle,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
