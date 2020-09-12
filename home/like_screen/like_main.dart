import 'package:flutter/material.dart';
import '../empty.dart';
import 'item_card.dart';
class LikeMain extends StatefulWidget {

  final List likes;

  LikeMain(this.likes);
  @override
  _LikeMainState createState() => _LikeMainState();
}

class _LikeMainState extends State<LikeMain> {
  @override
  Widget build(BuildContext context) {
    if(widget.likes.length > 0){
      return ListView.builder(
        itemCount: widget.likes.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (context , i){
          return Container(
            height: 115,
            //margin: EdgeInsets.symmetric(horizontal:3),
            padding: EdgeInsets.only(left: 10 , right: 10 , top: 5),
            child: ItemCard(
              id: widget.likes[i]['id'],
              shopName: widget.likes[i]['ShopName'],
              pic: widget.likes[i]['pic'],
              priceWithOff: widget.likes[i]['priceWithOff'],
              discount: widget.likes[i]['discount'].toString(),
              postName:  widget.likes[i]['postName'],
              type:  widget.likes[i]['type'],
              check: widget.likes[i]['check'],
            ),
          );
        },
      );
    }else{
      return showEmpty(context);
    }

  }
}





