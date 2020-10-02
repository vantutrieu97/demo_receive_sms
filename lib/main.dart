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
  String _signature = "{{ app signature }}";
  String _currentPhoneNumber = "";
  final SmsAutoFill smsAutoFillInstance = SmsAutoFill();

  void _startListenCode() async {
    print("Start listen code: ");
    await smsAutoFillInstance.listenForCode;
  }

  void _getAppSignature() async {
    _signature = await smsAutoFillInstance.getAppSignature;
    print("app signature: $_signature");
    setState(() {});
  }

  void _getCurrentPhoneNumber() async {
    _currentPhoneNumber = await smsAutoFillInstance.hint;
    debugPrint("debugPrint   [currentPhoneNumber] : $_currentPhoneNumber");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'App\'s signature: $_signature',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Text(
              'Dynamic code: $_code',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            Text(
              'Phone number: $_currentPhoneNumber',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(
              height: 24,
            ),
            FlatButton(
              onPressed: _getCurrentPhoneNumber,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Current phone number",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
            FlatButton(
              onPressed: _getAppSignature,
              child: Container(
                color: Colors.black,
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Get app signature",
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _startListenCode,
        child: Icon(Icons.add),
      ),
    );
  }
}
