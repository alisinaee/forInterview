import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../../http/http.dart';
import '../empty.dart';
import '../no_internet.dart';
import './best_sales/bestSalesPost.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import './list/home_header_list_widget.dart';
import './horizontal_list/horizantalList.dart';
import './hotpic/hot_pic.dart';
import './recent_post/recentpost.dart';
import './slider/swiper.dart';

class HomeWidget extends StatefulWidget {
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Http http = Http();

  void rebuild() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: http.vitrin(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          print(snapshot.data[0]['bestSalesPost'].length);
          return CustomScrollView(
            slivers: <Widget>[
              SliverStickyHeader(
                header: Container(),
                sliver: SliverList(
                    delegate: SliverChildListDelegate([
                  (snapshot.data[0]['ad'].length != [])
                      ? Container(
                          height: 170,
                          child: SliderAdd(snapshot),
                        )
                      : null,
                  //CategoryWidget(),
                ])),
              ),
              (snapshot.data[0]['hotPic'] != [])
                  ? SliverStickyHeader(
                      header: Container(),
                      sliver: HotPic(snapshot),
                    )
                  : null,
              (snapshot.data[0]['recentPost'].length != 0)
                  ? SliverStickyHeader(
                header: headerList(
                    context, 'آخرین تگ ها', 'assets/images/recent.png'),
                sliver: RecentPost(snapshot),
              )
                  : SliverList(
                  delegate: SliverChildListDelegate([
                    showEmpty(context),
                  ])),

              (snapshot.data[0]['foodPost'].length != 0)
                  ? SliverStickyHeader(
                      header: headerList(context, 'رستوران و کافی شاپ',
                          'assets/images/c2.png'),
                      sliver: HorizontalList(snapshot, 'foodPost'),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate([
                      showEmpty(context),
                    ])),
              (snapshot.data[0]['funPost'].length != 0)
                  ? SliverStickyHeader(
                      header: headerList(
                          context, 'تفریحی ورزشی', 'assets/images/c3.png'),
                      sliver: HorizontalList(snapshot, 'funPost'),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate([
                      showEmpty(context),
                    ])),
              (snapshot.data[0]['beautyPost'].length != 0)
                  ? SliverStickyHeader(
                      header: headerList(
                          context, 'زیبایی آرایشی', 'assets/images/c4.png'),
                      sliver: HorizontalList(snapshot, 'beautyPost'),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate([
                      showEmpty(context),
                    ])),
              (snapshot.data[0]['servicePost'].length != 0)
                  ? SliverStickyHeader(
                      header: headerList(
                          context, 'کالا و خدمات', 'assets/images/c5.png'),
                      sliver: HorizontalList(snapshot, 'servicePost'),
                    )
                  : SliverList(
                      delegate: SliverChildListDelegate([
                      showEmpty(context),
                    ])),
              (snapshot.data[0]['bestSalesPost'].length != 0)
                  ? SliverStickyHeader(
                header: headerList(
                    context, 'پرفروش ترین ها', 'assets/images/hot.png'),
                sliver: BestSalesPost(snapshot),
              )
                  : SliverList(
                  delegate: SliverChildListDelegate([
                    showEmpty(context),
                  ])),

            ],
          );
        } else if (snapshot.hasError) {
          return NoInternet(rebuild);
        }

// By default, show a loading spinner.
        return Center(
            child: Container(

              width: MediaQuery.of(context).size.width*9/10,
              height: MediaQuery.of(context).size.width*9/10,
              child: FlareActor("assets/flr/loading.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"loading",shouldClip: false ),
            ));
      },
    );
  }
}

/*
*/
