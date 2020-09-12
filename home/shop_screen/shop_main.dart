import 'package:flutter/material.dart';

import '../empty.dart';
import 'shop_card.dart';

class ShopMain extends StatefulWidget {
  final List data;

  ShopMain(this.data);

  @override
  _ShopMainState createState() => _ShopMainState();
}

class _ShopMainState extends State<ShopMain> {

  void update(int shopId){
    setState(() {
      print('done');
      widget.data.where((i){
        if(i['id'] == shopId)
          {
            i['isLike'] = !i['isLike'];
          }
        return true;
      }).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    if(widget.data.length> 0){
      return GridView.count(
        crossAxisCount: 2,
        childAspectRatio: (1.8/ 2),
        padding: EdgeInsets.only(top: 20 ,bottom: 10 , left: 2,right: 2),
        // Generate 100 widgets that display their index in the List.
        children: List.generate(widget.data.length, (index) {
          return shopCard(context, widget.data[index],update);
        }),
      );
    }else{
      return showEmpty(context);
    }

  }
}
