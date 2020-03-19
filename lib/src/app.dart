import 'package:flutter/material.dart';
import 'ui/home.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid19',
      theme: ThemeData(),
      home: MyHomePage(title: 'Covid Statistics'),
    );
  }
}

