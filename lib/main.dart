import 'package:flutter/material.dart';
import 'package:sms_autofill/sms_autofill.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget with CodeAutoFill {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  @override
  void codeUpdated() {
    // Tu ngu dang lam doan nay
    // TODO: implement codeUpdated
  }
}

class _MyHomePageState extends State<MyHomePage> {
  String _code = "";
  String signature = "{{ app signature }}";

  void _startListenCode() async {
    print("Start listen code: ");
    await SmsAutoFill().listenForCode;
  }

  void _getAppSignature() async {
    signature = await SmsAutoFill().getAppSignature;
    print("app signature: $signature");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_code',
              style: Theme.of(context).textTheme.headline4,
            ),
            GestureDetector(
              onTap: _getAppSignature,
              child: Container(
                child: Text("Get app signature"),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startListenCode,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
