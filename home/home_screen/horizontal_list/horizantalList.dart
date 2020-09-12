import 'package:flutter/material.dart';


import 'horizontal_post_card.dart';

class HorizontalList extends StatefulWidget {

  final AsyncSnapshot snapshot;
  final String typeOfData;

  HorizontalList(this.snapshot , this.typeOfData);
  @override
  _HorizontalListState createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  @override
  Widget build(BuildContext context) {
    var _controller = PageController(viewportFraction: 0.85);
    return SliverList(delegate: SliverChildListDelegate(<Widget> [
      Stack(
        children: <Widget>[
          Container(
              padding: EdgeInsets.only(top: 10,bottom: 10),
              child: _buildCarousel(context, 10, _controller,widget.snapshot ,widget.typeOfData)),
          Positioned(
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
              onPressed: () {
                setState(() {
                  _controller.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                });
              },
            ),
            left: 0,
            top: 0,
            bottom: 0,
          ),
          Positioned(
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios, color: Theme.of(context).primaryColor,),
              onPressed: () {
                setState(() {
                  _controller.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear);
                });
              },
            ),
            right: 0,
            top: 0,
            bottom: 0,
          ),
        ],
      )
    ]));
  }
}

Widget _buildCarousel(BuildContext context, int carouselIndex, _controller,snapshot ,typeOfData) {
  var data = snapshot.data[0][typeOfData];
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      //Text('Carousel $carouselIndex'),
      SizedBox(
        //width: 2000,
        // you may want to use an aspect ratio here for tablet support
        height: 300.0,
        child: PageView.builder(
          itemCount: data.length,
          reverse: true,
          physics: BouncingScrollPhysics(),
          // store this controller in a State to save the carousel scroll position
          controller: _controller,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal:3),
              child: HorizontalPostCard(
                id: data[i]['id'],
                title: data[i]['title'],
                address:  data[i]['shop_address'],
                discount:  data[i]['discount'].toString(),
                like:  data[i]['isLike'],
                pic:  data[i]['pic'],
                price:  data[i]['formatedPrice'],
                shopName:  data[i]['shop_name'],
                sold:  data[i]['sold'].toString(),
                priceWithOff: data[i]['priceWithOff'],
              ),
            );
          },
        ),
      )
    ],
  );
}




