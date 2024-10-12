import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView.builder(
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(top: 20, bottom: 20, left: 10),
                    child: Text("index = $index"),
                  );
                }),
          ),
          Expanded(
            flex: 3,
            child: ListView(children: generateChildren()),
          ),
        ],
      ),
    );
  }

  List<Widget> generateChildren() {
    List<Widget> result = [];
    var header2 = Container(
      height: 50,
      child: ListView.builder(
          itemCount: 3,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Text("header= $index");
          }),
    );

    result.add(header2);
    List<int> list = getMocklist();
    List<Widget> temp = list.map((index) => _item(index)).toList();
    result.addAll(temp);
    return result;
  }

  Widget _item(int index) {
    return Row(
      children: [
        Image.network(
          'http://172.16.64.127:3000/images/banner/1.jpeg',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Text(
            // 这sb当内容超出可剩余的空间，它不会自动换行，需要加上父控件exppanded
            "dddddddddddddddddddddddeeeeeeeeeeeeeeeeeeee = $index",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  List<int> getMocklist() {
    return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18];
  }
}
