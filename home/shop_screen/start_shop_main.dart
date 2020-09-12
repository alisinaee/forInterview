import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../../http/http.dart';
import '../no_internet.dart';
import 'shop_main.dart';

class StartShop extends StatefulWidget {
  @override
  _StartShopState createState() => _StartShopState();
}

class _StartShopState extends State<StartShop> {
  Http http = Http();
  void rebuild(){
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: http.shops(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ShopMain(snapshot.data);
        } else if (snapshot.hasError) {
          return NoInternet(rebuild);
        }
        return Center(child: Container(

          width: MediaQuery.of(context).size.width*9/10,
          height: MediaQuery.of(context).size.width*9/10,
          child: FlareActor("assets/flr/loading.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"loading",shouldClip: false ),
        ));
      },
    );
  }
}
