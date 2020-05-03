import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('QR Reader APP'),
        ),
        body: Center(
          child: Container(
            child: Text('Lector de codigos QR'),
          ),
        ),
      ),
    );
  }
}
