import 'package:flutter/material.dart';
import 'dsp_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Faust Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _gate = false;

  @override
  void initState() {
    DspApi.start();
    super.initState();
  }

  void _toggleBeep() {
    setState(() {
      _gate = !_gate;
    });

    DspApi.setParamValue(0, _gate ? 1 : 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: _toggleBeep,
          child: Text(_gate ? 'Stop' : 'Beep'),
          color: _gate ? Colors.red : Colors.amber,
        ),
      ),
    );
  }
}
