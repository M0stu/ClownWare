import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:operations/operations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XendY\'s Calculator',
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
      home: const MyHomePage(title: 'XendY\'s Calculator'),
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
  @override
  Widget build(BuildContext context) {
    Calculator cal = Calculator();

    final x = TextEditingController();

    final y = TextEditingController();

    double? z;
    String result;

    final a = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: x,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter First Number',
              ),
            ),
            TextField(
              controller: y,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Second Number',
              ),
            ),
            TextField(
              controller: a,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter an angle',
              ),
            ),
          ],
        ),
      ), //start

      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: const Alignment(0.65, 0.550), //center right
            child: FloatingActionButton(
              onPressed: () => {
                z = cal.addTwoNumbers(int.parse(x.text), int.parse(y.text))
                    as double?,
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
            alignment: const Alignment(0.100, 0.550), //center middle
            child: FloatingActionButton(
              onPressed: () => {
                z = cal.subTwoNumbers(int.parse(x.text), int.parse(y.text))
                    as double?,
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
              tooltip: 'Subtract',
              child: const Icon(CupertinoIcons.minus),
            ),
          ),
          Align(
            alignment: const Alignment(-0.45, 0.760), //bottom left
            child: FloatingActionButton(
              onPressed: () => {
                //come here OMAR  here is SIN  to make it
                // to make it SIN , COS , TAN in the bottom of app
                z = cal.mulTwoNumbers(int.parse(x.text), int.parse(y.text))
                    as double?,
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
              tooltip: 'Multiply',
              child: const Icon(CupertinoIcons.xmark),
            ),
          ),

          //problem here ya OMaaaaar double casting  bos 3la al ALIGN aly fo2  feha al sin
          //aly t7t dee hya al modulus mzboota
          // aly t7t al modulus cos
          //aly t7t al cos Tan
          Align(
            alignment: const Alignment(-0.45, 0.550), //center left
            child: FloatingActionButton(
              onPressed: () => {
                // this to MODULUS to make it easy in app
                z = cal.modulus(int.parse(x.text), int.parse(y.text))
                    as double?,
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
            alignment: const Alignment(0.1, 0.760), // bottom center
            child: FloatingActionButton(
              onPressed: () => {
                //please change this to COS
                z = cal.divTwoNumbers(int.parse(x.text), int.parse(y.text)),
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
              tooltip: 'Divide',
              child: const Icon(CupertinoIcons.divide),
            ),
          ),
          Align(
            alignment: const Alignment(0.65, 0.760),
            child: FloatingActionButton.extended(
              onPressed: () => {
                //please change this to TAN
                z = cal.powerVal(int.parse(x.text), int.parse(y.text)) as double?,
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
              tooltip: 'Power',
              label: const Text('Pow'),
            ),
          ),
          Align(
            alignment: const Alignment(-0.450, 1.0),
            child: FloatingActionButton.extended(
              onPressed: () => {
                z = cal.sinVal(double.parse(a.text)) ,
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
              label: const Text('Sin'),
            ),
          ),
          Align(
            alignment: const Alignment(0.100, 1.0),
            child: FloatingActionButton.extended(
              onPressed: () => {
                z = cal.cosVal(double.parse(a.text)),
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
              tooltip: 'Cos',
              label: const Text('Cos'),
            ),
          ),
          Align(
            alignment: const Alignment(0.650, 1.0),
            child: FloatingActionButton.extended(
              onPressed: () => {
                z = cal.tanVal(double.parse(a.text)) ,
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
              tooltip: 'Tan',
              label: const Text('Tan'),
            ),
          ),
        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
