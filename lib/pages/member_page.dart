import 'package:flutter/material.dart';
import 'package:flutter_shop_dx_last/log/log_constanst.dart';

import '../config/string.dart';

class MemberPage extends StatefulWidget {
  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 这里放置需要滚动的 Widgets
            _topHeader(),
            _orderTitle(),
            _orderType(),
            _actionList(),
          ],
        ),
      ),
    );
  }

  //头像区域
  Widget _topHeader() {
    return Container(
      color: Colors.red,
      // 使用 double.infinity,填充父widget
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
        child: Column(
          children: [
            Image.asset(
              'assets/images/girl.jpeg',
              fit: BoxFit.cover,
              width: 150,
              height: 150,
            ),
            Text('段霞')
          ],
        ),
      ),
    );
  }

  //我的订单标题
  Widget _orderTitle() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8,
        bottom: 8,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 24),
            child: Image.asset(
              'assets/images/icon_menu.png',
              fit: BoxFit.cover,
              width: 20,
              height: 20,
            ),
          ),
          Text('我的订单'),

          // 填充空白空间
          Expanded(flex: 1, child: Container()),

          Image.asset(
            'assets/images/arrow_right.png',
            fit: BoxFit.cover,
            width: 20,
            height: 20,
          ),
        ],
      ),
    );
  }

  //我的订单类型
  Widget _orderType() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 14, bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _orderTypeItem(Icons.payment, KString.pendingPayText), //'待付款'
          _orderTypeItem(Icons.directions_car, KString.toBeSendText), //'待发货'
          _orderTypeItem(
              Icons.directions_car, KString.toBeReceivedText), //'待付款'
          _orderTypeItem(Icons.message, KString.evaluateText), //'待评价'
        ],
      ),
    );
  }

  Widget _orderTypeItem(IconData? icon, String data) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30,
        ),
        Text(data),
      ],
    );
  }

  //其它操作列表
  Widget _actionList() {
    return Column(
      children: [
        _myListTile('领取优惠券'),
        _myListTile('已领取优惠券'),
        _myListTile('地址管理'),
        _myListTile('客服电话'),
        _myListTile('关于我们'),
      ],
    );
  }

  Widget _myListTile(String title) {
    return InkWell(
      onTap: () {
        myPrint('click title = $title');
      },
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.red),
          ),
        ),
        child: ListTile(
          leading: const Icon(Icons.blur_circular),
          title: Text(title),
          trailing: const Icon(Icons.arrow_right),
        ),
      ),
    );
  }
}
