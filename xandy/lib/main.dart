import 'package:flutter/material.dart';
import 'package:operations/operations.dart';

void main() {
  runApp(const MyApp());
  Calculator cal = new Calculator();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'X and Y',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'X and Y'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    Calculator cal = new Calculator();

    final x = new TextEditingController();

    final y = new TextEditingController();
    int z;
    String result;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: x,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter First Number X',
              ),
            ),
            TextField(
              controller: y,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Second Number Y',
              ),
            ),
          ],
        ),
      ), //start

      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment(1.1, 0.550), //center right
            child: FloatingActionButton(
              onPressed: () => {
                z = cal.addTwoNumbers(int.parse(x.text), int.parse(y.text)),
                result = z.toString(),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                ),
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            ),
          ),
          Align(
            alignment: Alignment(0.100, 0.550), //center middle
            child: FloatingActionButton(
              onPressed: () => {
                z = cal.subTwoNumbers(int.parse(x.text), int.parse(y.text)),
                result = z.toString(),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                ),
              },
              tooltip: 'minus',
              child: const Icon(Icons.exposure_minus_1),
            ),
          ),
          Align(
            alignment: Alignment(-0.9, 1.0), //bottom left
            child: FloatingActionButton(
              onPressed: () => {
                //come here OMAR  here is SIN  to make it
                // to make it SIN , COS , TAN in the bottom of app
                z = cal.addTwoNumbers(int.parse(x.text), int.parse(y.text)),
                result = z.toString(),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                ),
              },
              tooltip: 'Sin',
              child: const Icon(Icons.waves),
            ),
          ),

          //problem here ya OMaaaaar double casting  bos 3la al ALIGN aly fo2  feha al sin
          //aly t7t dee hya al modulus mzboota
          // aly t7t al modulus cos
          //aly t7t al cos Tan
          Align(
            alignment: Alignment(-0.9, 0.550), //center left
            child: FloatingActionButton(
              onPressed: () => {
                // this to MODULUS to make it easy in app
                z = cal.modulus(int.parse(x.text), int.parse(y.text)),
                result = z.toString(),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                ),
              },
              tooltip: 'Modulus',
              child: const Icon(Icons.percent),
            ),
          ),
          Align(
            alignment: Alignment(0.1, 1.0), // bottom center
            child: FloatingActionButton(
              onPressed: () => {
                //please change this to COS
                z = cal.subTwoNumbers(int.parse(x.text), int.parse(y.text)),
                result = z.toString(),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                ),
              },
              tooltip: 'Add',
              child: const Icon(Icons.content_cut_sharp),
            ),
          ),
          Align(
            alignment: Alignment(1.10, 1.0),
            child: FloatingActionButton(
              onPressed: () => {
                //please change this to TAN
                z = cal.subTwoNumbers(int.parse(x.text), int.parse(y.text)),
                result = z.toString(),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                ),
              },
              tooltip: 'Add',
              child: const Icon(Icons.tag_rounded),
            ),
          ),
          Align(
            alignment: Alignment(-0.450, 0.750),
            child: FloatingActionButton(
              onPressed: () => {
                z = cal.subTwoNumbers(int.parse(x.text), int.parse(y.text)),
                result = z.toString(),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                ),
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            ),
          ),
          Align(
            alignment: Alignment(0.100, 0.7600),
            child: FloatingActionButton(
              onPressed: () => {
                z = cal.subTwoNumbers(int.parse(x.text), int.parse(y.text)),
                result = z.toString(),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                ),
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            ),
          ),
          Align(
            alignment: Alignment(0.650, 0.760),
            child: FloatingActionButton(
              onPressed: () => {
                z = cal.subTwoNumbers(int.parse(x.text), int.parse(y.text)),
                result = z.toString(),
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text(result),
                    );
                  },
                ),
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
