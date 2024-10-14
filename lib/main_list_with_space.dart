import 'package:flutter/material.dart';

void main() => runApp(const SpacedItemsList());

class SpacedItemsList extends StatelessWidget {
  const SpacedItemsList({super.key});

  @override
  Widget build(BuildContext context) {
    const items = 14;

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        cardTheme: CardTheme(color: Colors.blue.shade50),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                // spaceBetween 适合内容大小小于可用空间
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                    items,
                    (index) => ItemWidget(
                          text: 'Item $index',
                          index: index,
                        )),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
    required this.index,
  });

  final String text;
  final int index;

  @override
  Widget build(BuildContext context) {
    // return Card(
    //   child: SizedBox(
    //     height: 100,
    //     child: Center(child: Text(text)),
    //   ),
    // );
    Color c = index % 2 == 0 ? Colors.blue : Colors.red;
    return Container(
      height: 100,
      color: c,
    );
  }
}
