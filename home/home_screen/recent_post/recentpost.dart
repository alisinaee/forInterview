import 'package:flutter/material.dart';
import '../list/post_card.dart';

class RecentPost extends StatelessWidget {
  final AsyncSnapshot snapshot;

  RecentPost(this.snapshot);

  @override
  Widget build(BuildContext context) {
    var data = snapshot.data[0]['recentPost'];
    return SliverList(
      delegate: new SliverChildBuilderDelegate(
        (context, i) => PostCard(
          id: data[i]['id'],
          title: data[i]['title'],
          address: data[i]['shop_address'],
          discount: data[i]['discount'].toString(),
          like: data[i]['isLike'],
          pic: data[i]['pic'],
          price: data[i]['formatedPrice'],
          shopName: data[i]['shop_name'],
          sold: data[i]['sold'].toString(),
          priceWithOff: data[i]['priceWithOff'],
        ),
        childCount: data.length,
      ),
    );
  }
}

