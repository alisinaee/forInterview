import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_card/animated_card.dart';
import '../../../http/http.dart';
import 'package:like_button/like_button.dart';
import '../../../flusher/flusher.dart' as flusher;

class PostCard extends StatefulWidget {
  final String title;
  final String shopName;
  final String address;
  final String price;
  final String priceWithOff;
  final String discount;
  final String pic;
  final String sold;
  bool like;
  final int id;

   PostCard(
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
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
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

  Future<bool> onLikeButtonTap(bool isLiked,int id) async{
    Http http = Http();
    String token =await http.getTokenFromStorage();
    if(token == null){
      flusher.FlusherSetterAskForSign(context , 'هشدار !' , 'ابتدا وارد حساب کاربری خود شوید یا حساب جدید ایجاد نمایید' , Icons.lock ,Colors.yellow);
      return null;
    }else{
      final Completer<bool> completer = new Completer<bool>();
      Timer(const Duration(milliseconds: 200), () {

        likeBtn(id);

        // if your request is failed,return null,
        completer.complete(!isLiked);
      });
      return completer.future;
    }

  }



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double widthForText = width / 2.7;
    return Container(
      padding: EdgeInsets.all(0),
      width: width,
      height: width * 11/30,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/startPost/${widget.id}');
        },
        child: AnimatedCard(
          direction: AnimatedCardDirection.right,
          //Initial animation direction
          initDelay: Duration(milliseconds: 500),
          //Delay to initial animation
          duration: Duration(milliseconds: 500),
          keepAlive: true,
          child: Card(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Colors.white,
            margin: EdgeInsets.all(10),
            elevation: 2,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: CachedNetworkImage(
                            imageUrl:
                                "https://www.mocatag.ir/uploads/picture/post/web/thumb/${widget.pic}",
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
                        top: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
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
                          padding: EdgeInsets.all(5),
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
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              stops: [0.1, 0.5, 0.7, 0.9],
                              colors: [
                                Colors.white70,
                                Colors.white54,
                                Colors.white10,
                                Colors.transparent,
                              ],
                            ),
                          ),
                          padding:
                              EdgeInsets.only(left: 2, bottom: 1, right: 20),
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
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Icon(
                                Icons.shopping_basket,
                                color: Colors.purple[700],
                                size: 19,
                              ),
                            ],
                          ),
                          //color: Colors.black38,
                        ),
                      ),
                    ],
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 10, bottom: 10, left: 5, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              //width: 100.0,
                              height: 25.0,
                              padding:
                                  EdgeInsets.only(top: 4, right: 11, left: 11),
                              decoration: new BoxDecoration(
                                color: Colors.deepPurple[400],
                                //border: new Border.all(color: Colors.white, width: 2.0),
                                borderRadius: new BorderRadius.circular(50.0),
                              ),
                              child: new Center(
                                child: new Text(
                                  widget.priceWithOff,
                                  style: new TextStyle(
                                      fontSize: 11.0, color: Colors.white),
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
                              padding:
                                  EdgeInsets.only(top: 4, right: 11, left: 11),
                              decoration: new BoxDecoration(
                                color: Colors.black26,
                                //border: new Border.all(color: Colors.white, width: 2.0),
                                borderRadius: new BorderRadius.circular(50.0),
                              ),
                              child: new Center(
                                child: new Text(
                                  widget.price,
                                  style: new TextStyle(
                                      fontSize: 9.0,
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
                                      fontSize: 9, color: Colors.deepPurple)),
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
                                  transform:
                                      Matrix4.translationValues(0, 3, 0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '%',
                                        style: new TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      //SizedBox(width: 2,),
                                      Text(
                                        widget.discount,
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
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
                                      fontSize: 7,
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
                  flex: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
