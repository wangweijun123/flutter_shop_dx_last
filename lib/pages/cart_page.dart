import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('购物车'),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 50,
                  itemBuilder: (BuildContext context, int index) {
                    return _itemCart(index);
                  }),
            ),
            Container(
              color: Colors.amber,
              child: const Row(
                children: [
                  Text('底部'),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text('底部'),
                        Text('底部'),
                        Text('底部'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Text _itemCart(int index) {
    return Text(
      'index = $index',
      style: const TextStyle(
        fontSize: 30,
      ),
    );
  }
}
