import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';

Widget showEmpty(BuildContext context){
  return Column(
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
          child: Text(' موردی برای نمایش یافت نشد !' ,
            style: TextStyle(color: Colors.grey , fontSize: 16,fontWeight: FontWeight.bold),
            textDirection: TextDirection.rtl,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}