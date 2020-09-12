import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:animated_card/animated_card.dart';



class HotPic extends StatelessWidget {
  final AsyncSnapshot snapshot;

  HotPic(this.snapshot);


  @override
  Widget build(BuildContext context) {

    var data = snapshot.data[0]['hotPic'];
    return SliverList(
      delegate: new SliverChildBuilderDelegate(
            (context, i) =>  AnimatedCard(
              direction: AnimatedCardDirection.right, //Initial animation direction
              initDelay: Duration(milliseconds: 400), //Delay to initial animation
              duration: Duration(milliseconds: 450),
              keepAlive: true,
              child: Container(
                width: double.infinity,
                height: 145,
                padding: EdgeInsets.only(top: 0 , bottom: 0 , right: 20,left: 20),
                child: Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  margin: EdgeInsets.all(10),
                  elevation: 2,
                  child: InkWell(
                    onTap: (){
                      if(data[i]['post_id'] != null)
                        {
                          Navigator.pushNamed(context, '/startPost/${data[i]['post_id']}');
                        }

                    },
                    child: CachedNetworkImage(
                        imageUrl:
                        'https://www.mocatag.ir/' + data[i]['thumblink'],
                        placeholder: (context, url) => Center(child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        )),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                        fit: BoxFit.cover),
                  ),

                ),
              ),
            ),
        childCount: data.length,
      ),
    );
  }
}


/*
ListTile(
leading: new CircleAvatar(
backgroundColor: Colors.red,
child: new Text(i.toString()),
),
title: new Text(snapshot.data[0]['bestSalesPost'][i]['title']),
)*/
