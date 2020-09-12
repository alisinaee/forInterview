import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../empty.dart';
import 'item_card.dart';


class History extends StatefulWidget {
  History(this.data);

  final List data;

  @override
  _HistoryState createState() => new _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    List orders = widget.data[0]['orders'];
    if(orders.length > 0){
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'تگ های خریداری شده',
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.history,
                      size: 20,
                      color: Colors.purple,
                    )
                  ],
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'جهت جابجایی بین تگ ها به سمت بالا یا پایین بکشید',
                  style: TextStyle(color: Colors.grey, fontSize: 8),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  'جهت مشاهده QR (کیو ار کد ) یا کد خرید بروی تگ کلیک کنید',
                  style: TextStyle(color: Colors.grey, fontSize: 8),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
                height: MediaQuery.of(context).size.height * 26 / 40,
                //width: 300,
                child: ItemCard(orders)),
          ),
        ],
      );
    }else{
      return showEmpty(context);
    }

  }
}















