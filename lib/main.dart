import 'package:flutter/material.dart';
import 'package:shopping/util/dbhelper.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DbHelper helper = DbHelper();
    helper.tesdDb();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
