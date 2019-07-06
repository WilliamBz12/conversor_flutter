import 'package:flutter/material.dart';
import 'package:conversos_app/main.dart';
import 'dart:async';


const resquest = "https://api.hgbrasil.com/finance?key=40874e20";

class Tela1 extends StatefulWidget {
  @override
  _Tela1State createState() => _Tela1State();
}

class _Tela1State extends State<Tela1> {

  final realcontroller = TextEditingController();
  final dolarcontroller = TextEditingController();
  final eurocontroller = TextEditingController();


  double dollar, euro;
  
  //Changed in real TextField
  realchange(String text){
    double _real = double.parse(text);
    dolarcontroller.text = (_real/dollar).toStringAsFixed(2);
    eurocontroller.text = (_real/euro).toStringAsFixed(2);

  }
  dolarchange(String text){
    double _dolar = double.parse(text);
    realcontroller.text = (_dolar *this.dollar).toStringAsFixed(2);
    eurocontroller.text = (_dolar*this.dollar/euro).toStringAsFixed(2);

  }
  eurohange(String text){

    double _euro = double.parse(text);
    realcontroller.text = (_euro *this.euro).toStringAsFixed(2);
    dolarcontroller.text = (_euro*this.euro/dollar).toStringAsFixed(2);


  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("conversor"),
      ),
        body: FutureBuilder<Map>(
            future: getData(),
            builder: (context, snapshot){
              switch (snapshot.connectionState){
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Text("carregando..."),
                  );
                default:
                  if(snapshot.hasError){
                    return Center(
                      child: Text("erro"),
                    );
                  } else {
                    dollar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(

                      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
                      child: Column(

                        children: <Widget>[
                          getTextFiled("real", realcontroller, realchange),
                          Divider(),
                          getTextFiled("dolar", dolarcontroller, dolarchange),
                          Divider(),
                          getTextFiled("euro", eurocontroller, eurohange)
                        ],
                      ),
                    );

                  }

              }

            }),
    );
  }
}


//TextFiled model
Widget getTextFiled (String label, TextEditingController c, Function f){

  return TextField(
    controller: c,
    keyboardType: TextInputType.number,
    decoration: InputDecoration(
        labelText: label ,
        border: OutlineInputBorder(),


    ),
    onChanged: f,
  );


}
