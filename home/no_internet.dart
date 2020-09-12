import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:mocatag/http/http.dart';

class NoInternet extends StatefulWidget {
  final Function rebuild;
  NoInternet(this.rebuild);

  @override
  _NoInternetState createState() => _NoInternetState();
}

class _NoInternetState extends State<NoInternet> {

  Timer timer;
  Http http = Http();
  //
  void checkInternet() async{
    var result = await http.checkInternetConnection();
    print(result);
    if(result == 'done'){
      widget.rebuild();
    }
  }
  //
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) => checkInternet());
  }
  //
  @override
  void dispose() {

    super.dispose();
    timer?.cancel();
  }
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
        Theme.of(context).scaffoldBackgroundColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ListView(
          children: <Widget>[
            SizedBox(height: 80,),
            Container(
              width: MediaQuery.of(context).size.width*8/10,
              height: MediaQuery.of(context).size.width*8/10,
              child: FlareActor("assets/flr/ni.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"init"),
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('دسترسی به اینترنت وجود ندارد!' ,
                  style: TextStyle(color: Colors.grey , fontSize: 18,fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
