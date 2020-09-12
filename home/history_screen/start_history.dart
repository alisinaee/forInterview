import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../../http/http.dart';
import '../need_auth.dart';
import '../no_internet.dart';
import 'history.dart';

class StartHistory extends StatefulWidget {


  @override
  _StartHistoryState createState() => _StartHistoryState();
}

class _StartHistoryState extends State<StartHistory> {
  Http http = Http();
  void rebuild(){
    setState(() {
    });
  }
  String token;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    http.getTokenFromStorage().then((result){
      setState(() {
        token = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    if(token == null){
      return NeedAuth();
    }else{
      return FutureBuilder(
          future:http.orders(token),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return History(snapshot.data);
            }
            else if (snapshot.hasError) {
              return NoInternet(rebuild);
            }

            return Center(
              child:Container(

                width: MediaQuery.of(context).size.width*9/10,
                height: MediaQuery.of(context).size.width*9/10,
                child: FlareActor("assets/flr/loading.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"loading",shouldClip: false ),
              ),

            );
          }
      );
    }
  }
}
