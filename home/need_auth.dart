import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';


class NeedAuth extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(
        Theme.of(context).scaffoldBackgroundColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(

              width: MediaQuery.of(context).size.width*4/10,
              height: MediaQuery.of(context).size.width*4/10,
              child: FlareActor("assets/flr/chomper.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"Game Over",shouldClip: false, ),
            ),
            SizedBox(height: 40,),
            Container(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Text('شما به صورت مهمان وارد شده اید ،  وارد حساب کاربری خود شوید و یا حساب جدید ایجاد نمایید !' ,
                  style: TextStyle(color: Colors.grey , fontSize: 15,fontWeight: FontWeight.bold),
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(left: 40, right: 40),
              child: RaisedButton(
                  onPressed: (){Navigator.pushNamed(context, '/auth');},
                  textColor: Theme.of(context).primaryColorDark,
                  color: Theme.of(context).primaryColorLight,
                  padding: const EdgeInsets.all(8.0),
                  child: new Text(
                    "عضویت  /  ایجاد حساب",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(10.0))),
            ),
          ],
        ),
      ),
    );
  }
}
