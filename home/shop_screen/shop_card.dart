import 'dart:async';
import '../../flusher/flusher.dart' as flusher;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animated_card/animated_card.dart';
import 'package:like_button/like_button.dart';
import 'package:mocatag/http/http.dart';

Widget shopCard(BuildContext context, Map data, Function update) {
  String pic = data['pic'];
  String title = data['name'];
  String address = data['address'];
  double width = MediaQuery.of(context).size.width;
  double widthForText = width * 0.37;
  int id = data['id'];
  bool like = data['isLike'];

  //
  void likeBtn(int shopId) async {
    Http http = Http();
    var result = await http.like(null, shopId.toString());
    if (result == "shop like done" || result == "shop unlike done") {

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

  return AnimatedCard(
    direction: AnimatedCardDirection.top,
    //Initial animation direction
    initDelay: Duration(milliseconds: 500),
    //Delay to initial animation
    duration: Duration(milliseconds: 500),
    keepAlive: true,
    child: Container(
      padding: EdgeInsets.all(0),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.white,
        elevation: 1,
        margin: EdgeInsets.only(top: 5, bottom: 5, right: 5, left: 5),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/startShop/$id');
          },
          child: Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: CachedNetworkImage(
                          imageUrl:
                              "https://www.mocatag.ir/uploads/picture/shop/web/thumb/" +
                                  pic,
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
                      left: 0,
                      child: InkWell(
                        onTap: () {
                          likeBtn(id);
                        },
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
                          padding: EdgeInsets.all(2),
                          child: LikeButton(
                            onTap: (bool isLiked)
                            {
                              return onLikeButtonTap(isLiked,id);
                            },
                            isLiked: like,
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
                  ],
                ),
                flex: 4,
              ),
              Expanded(
                child: Container(
                  padding:
                      EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: widthForText,
                        child: Text(
                          title,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 10,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: widthForText,
                            child: Text(
                              address,
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.indigo[300],
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
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
                  ),
                  //color: Colors.blue,
                ),
                flex: 3,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
