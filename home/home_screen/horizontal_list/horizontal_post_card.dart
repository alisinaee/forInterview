import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../http/http.dart';
import 'package:like_button/like_button.dart';

class HorizontalPostCard extends StatefulWidget {
  final String title;
  final int id;
  final String shopName;
  final String address;
  final String price;
  final String priceWithOff;
  final String discount;
  final String pic;
  final String sold;
  bool like;

   HorizontalPostCard(
      {this.id,
      this.title,
      this.shopName,
      this.address,
      this.price,
      this.priceWithOff,
      this.discount,
      this.pic,
      this.sold,
      this.like});

  @override
  _HorizontalPostCardState createState() => _HorizontalPostCardState();
}

class _HorizontalPostCardState extends State<HorizontalPostCard> {
  //
  void likeBtn(int postId) async {
    Http http = Http();
    var result = await http.like(postId.toString(), null);
    if (result == "post like done" || result == "post unlike done") {

    }
    else{
      //return error
    }
  }

  Future<bool> onLikeButtonTap(bool isLiked,int id) {
    ///send your request here
    ///
    final Completer<bool> completer = new Completer<bool>();
    Timer(const Duration(milliseconds: 200), () {

      likeBtn(id);

      // if your request is failed,return null,
      completer.complete(!isLiked);
    });
    return completer.future;
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double widthForText = width * 5 / 10;
    return Container(
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.all(10),
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/startPost/${widget.id}');
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  height: 160,
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: CachedNetworkImage(
                            imageUrl:
                                'https://www.mocatag.ir/uploads/picture/post/web/thumb/${widget.pic}',
                            placeholder: (context, url) => Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: CircularProgressIndicator(),
                                )),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.cover),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: (){
                            likeBtn(widget.id);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomRight,
                                end: Alignment.bottomLeft,
                                stops: [0.1, 0.5, 0.7, 0.9],
                                colors: [
                                  Colors.white70,
                                  Colors.white54,
                                  Colors.white10,
                                  Colors.transparent,
                                ],
                              ),
                            ),
                            padding: EdgeInsets.only(
                                right: 2, left: 20, bottom: 2, top: 2),
                            child: LikeButton(
                              onTap: (bool isLiked)
                              {
                                return onLikeButtonTap(isLiked,widget.id);
                              },
                              isLiked: widget.like,
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  isLiked ?Icons.favorite :Icons.favorite_border ,
                                  color: Colors.red[600],
                                  size: 25,
                                );
                              },
                            ),
                            //color: Colors.black38,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.bottomRight,
                              stops: [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                Colors.white70,
                                Colors.white54,
                                Colors.white10,
                                Colors.transparent,
                              ],
                            ),
                          ),
                          padding: EdgeInsets.only(
                              left: 2, bottom: 1, right: 35, top: 4),
                          child:(double.parse(widget.sold) == 0)?Text(
                            ' جدید ',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ): Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                widget.sold,
                                style: TextStyle(
                                    color: Colors.indigo,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.shopping_basket,
                                color: Colors.purple[700],
                                size: 22,
                              ),
                            ],
                          ),
                          //color: Colors.black38,
                        ),
                      ),
                    ],
                  )),
              Container(
                height: 120,
                width: double.infinity,
                padding:
                    EdgeInsets.only(top: 5, bottom: 15, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          //width: 100.0,
                          height: 25.0,
                          padding: EdgeInsets.only(top: 6, right: 11, left: 11),
                          decoration: new BoxDecoration(
                            color: Colors.deepPurple[400],
                            //border: new Border.all(color: Colors.white, width: 2.0),
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          child: new Center(
                            child: new Text(
                              widget.priceWithOff,
                              style: new TextStyle(
                                  fontSize: 12.0, color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          width: widthForText,
                          child: Text(
                            widget.title,
                            maxLines: 2,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          //width: 100.0,
                          height: 23.0,
                          padding: EdgeInsets.only(top: 4, right: 11, left: 11),
                          decoration: new BoxDecoration(
                            color: Colors.black26,
                            //border: new Border.all(color: Colors.white, width: 2.0),
                            borderRadius: new BorderRadius.circular(50.0),
                          ),
                          child: new Center(
                            child: new Text(
                              widget.price,
                              style: new TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.white,
                                  decoration: TextDecoration.lineThrough),
                            ),
                          ),
                        ),
                        Container(
                          width: widthForText,
                          child: Text(widget.shopName,
                              maxLines: 2,
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 10, color: Colors.deepPurple)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          height: 35,
                          child: CircleAvatar(
                            backgroundColor: Colors.red,
                            child: Transform(
                              transform: Matrix4.translationValues(0, 3, 0.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '%',
                                    style: new TextStyle(
                                        fontSize: 10.5, color: Colors.white70 , fontWeight: FontWeight.bold),

                                  ),
                                  //SizedBox(width: 2,),
                                  Text(
                                    widget.discount,
                                    style: new TextStyle(
                                        fontSize: 13.0, color: Colors.white , fontWeight: FontWeight.bold),

                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: widthForText,
                              child: Text(
                                widget.address,
                                style: TextStyle(
                                  fontSize: 8,
                                  color: Colors.indigo[300],
                                ),
                                maxLines: 2,
                                textAlign: TextAlign.right,
                                textDirection: TextDirection.rtl,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Icon(Icons.location_on,
                                size: 15, color: Colors.purple[300])
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                //color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
