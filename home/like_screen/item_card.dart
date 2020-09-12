import 'dart:async';

import 'package:animated_card/animated_card.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import '../../http/http.dart';
import 'package:parallax_image/parallax_image.dart';

class ItemCard extends StatelessWidget {
  final String type;
  final String pic;
  final String postName;
  final String shopName;
  final String priceWithOff;
  final int id;
  final String discount;
  final String check;

  ItemCard(
      {this.id,
      this.pic,
      this.type,
      this.postName,
      this.priceWithOff,
      this.discount,
      this.shopName,
      this.check});

  @override
  Widget build(BuildContext context) {
    //
    void likeBtn(int id, String type) async {
      Http http = Http();
      var result;
      if (type == 'post') {
        result = await http.like(id.toString(), null);
      } else {
        result = await http.like(null,
            id.toString());
      }
      if (result == "post like done" ||
          result == "post unlike done" ||
          result == "shop unlike done" ||
          result == "shop unlike done") {
      } else {
        //return error
      }
    }

    Future<bool> onLikeButtonTap(bool isLiked, int id, String type) {
      final Completer<bool> completer = new Completer<bool>();
      Timer(const Duration(milliseconds: 200), () {
        likeBtn(id, type);

        // if your request is failed,return null,
        completer.complete(!isLiked);
      });
      return completer.future;
    }

    //
    return Container(
      child: AnimatedCard(
        direction: AnimatedCardDirection.left,
        //Initial animation direction
        initDelay: Duration(milliseconds: 300),
        //Delay to initial animation
        duration: Duration(milliseconds: 500),
        keepAlive: false,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.white,
          margin: EdgeInsets.all(0),
          elevation: 2,
          child: InkWell(
            onTap: () {
              if(type == 'post'){
                Navigator.pushNamed(context, '/startPost/$id');
              }
              else{
                Navigator.pushNamed(context, '/startShop/$id');
              }
            },
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                    child: ClipRRect(
                  borderRadius: new BorderRadius.circular(10.0),
                  child: ParallaxImage(
                    image: (type == 'post')
                        ? CachedNetworkImageProvider(
                            "https://www.mocatag.ir/uploads/picture/post/web/thumb/$pic")
                        : CachedNetworkImageProvider(
                            "https://www.mocatag.ir/uploads/picture/shop/web/thumb/$pic"),
                    extent: 100,
                  ),
                )),
                Positioned.fill(
                  child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          stops: [0.1, 0.3, 0.7, 0.9],
                          colors: [
                            Colors.black45,
                            Colors.black45,
                            Colors.black45,
                            Colors.black45,
                          ],
                        ),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            LikeButton(
                              isLiked: true,
                              onTap: (bool isLiked) {
                                return onLikeButtonTap(isLiked, id, type);
                              },
                              likeBuilder: (bool isLiked) {
                                return Icon(
                                  isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: Colors.red[500],
                                  size: 30,
                                );
                              },
                            ),
                            //
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width: 250,
                                  child: (type == 'post')
                                      ? Text(
                                    postName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    softWrap: true,
                                    maxLines: 2,
                                  )
                                      : Text(
                                    shopName,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    softWrap: true,
                                    maxLines: 2,
                                  ),
                                ),
                                Visibility(
                                  visible: check!='null',
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      check,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                      textAlign: TextAlign.center,
                                      textDirection: TextDirection.rtl,
                                      softWrap: true,
                                      maxLines: 2,
                                    ),
                                  ),

                                )
                              ],
                            ),

                            (type == 'post')
                                ? Icon(
                                    Icons.local_offer,
                                    color: Colors.white70,
                                    size: 25,
                                  )
                                : Icon(
                                    Icons.store_mall_directory,
                                    color: Colors.white70,
                                    size: 25,
                                  ),
                          ],
                        ),
                      )
                      //color: Colors.black38,
                      ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
