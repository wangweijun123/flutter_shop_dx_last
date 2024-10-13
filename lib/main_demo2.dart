import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  State<MyHomePage> createState() {
    var myHomepageState = _MyHomePageState();
    print(
        'createState MyHomePage = ${this.hashCode}, myHomepageState = ${myHomepageState.hashCode}');
    return myHomepageState;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // 只要你setState，就会重新build 调用
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        'build widget = ${widget}, ${widget.hashCode}, _MyHomePageState = ${this.hashCode}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ThirdWidget(),
            FourthWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 第三个widget
class ThirdWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ThirdWidgetState();
  }
}

class _ThirdWidgetState extends State<ThirdWidget> {
  int count = 0;

  incrementCount() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('我是第三个widget re build');
    return Column(
      children: [
        Text("count = $count"),
        ElevatedButton(
            onPressed: () {
              incrementCount();
            },
            child: Text('third widget click me'))
      ],
    );
  }
}

// 状态关联的widget, 这个状态变化，只会rebuild 管理这个状态的widget rebuild(),
// 注意父widget的状态变化，所有的子widget 都会重建 rebuild
class FourthWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FourthWidgetState();
  }
}

class _FourthWidgetState extends State<FourthWidget> {
  int count = 0;

  incrementCount() {
    setState(() {
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('我是第四个widget re build');
    return Column(
      children: [
        Text("count = $count"),
        ElevatedButton(
            onPressed: () {
              incrementCount();
            },
            child: Text('fourth widget click me'))
      ],
    );
  }
}
