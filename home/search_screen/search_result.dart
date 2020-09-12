import 'package:flutter/material.dart';
import '../empty.dart';
import '../home_screen/list/post_card.dart';

class SearchResult extends StatelessWidget {
  final List data;
  final String categoryText;
  final String searchText;

  SearchResult(this.data, this.categoryText, this.searchText);

  //
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 10, bottom: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    (searchText == ' ') ? " همه " : searchText,
                    style: TextStyle(color: Colors.deepPurple, fontSize: 12),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'نتایج عبارت : ',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    categoryText?? '',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 12),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'دسته بندی : ',
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
        (data.length > 0)
            ? Expanded(
                child: ListView.builder(
                  itemBuilder: (context, i) {
                    return PostCard(
                      id: data[i]['id'],
                      title: data[i]['name'],
                      address: data[i]['address'],
                      discount: data[i]['discount'].toString(),
                      like: data[i]['isLike'],
                      pic: data[i]['pic'],
                      price: data[i]['price'],
                      shopName: data[i]['shop'],
                      sold: data[i]['sold'],
                      priceWithOff: data[i]['priceWithOff'],
                    );
                  },
                  itemCount: data.length,
                ),
              )
            : Container(padding: EdgeInsets.only(top: 50),child: showEmpty(context),),
      ],
    );
  }
}
