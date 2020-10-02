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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with CodeAutoFill {
  String _code = "";
  bool isFirst = true;
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
    final SmsAutoFill _autoFill = SmsAutoFill();
    String a, b;
    _autoFill.hint.then(
        (value) => {
              a = "123",
            },
        onError: (error) => {
              b = "abc",
            });
    _currentPhoneNumber = await SmsAutoFill().hint;
    debugPrint("debugPrint   [currentPhoneNumber] : $_currentPhoneNumber");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _startListenCode();
    _getAppSignature();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      backgroundColor: Colors.grey,
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.transparent,
              child: PinFieldAutoFill(
                codeLength: 6,
                onCodeChanged: (value) => {onGetCode(value)},
              ),
            ),
            Container(
              color: Colors.grey,
              constraints: BoxConstraints.expand(),
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
                    height: 60,
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
                ],
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

  @override
  void codeUpdated() {
    setState(() {
      _code = code;
    });
    // TODO: implement codeUpdated
  }

  void onGetCode(String str) {
    if (str.isEmpty) {
      String a = "sdasd";
    } else {
      setState(() {
        _code = str;
      });
    }
  }
}
