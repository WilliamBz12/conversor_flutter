import 'package:flutter/material.dart';
import 'view/tela1.dart';


import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';


void main() async {

  runApp(MyApp());}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Tela1(),
    );
  }
}

Future<Map> getData() async{
  http.Response resp = await http.get(resquest);
  return  json.decode(resp.body);
}