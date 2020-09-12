import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animated_card/animated_card.dart';
import 'package:url_launcher/url_launcher.dart';

class SliderAdd extends StatelessWidget {
  final AsyncSnapshot snapshot;
  _goToUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  SliderAdd(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      direction: AnimatedCardDirection.right, //Initial animation direction
      initDelay: Duration(milliseconds: 300), //Delay to initial animation
      duration: Duration(milliseconds: 350),
      keepAlive: true,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 20),
        child: Swiper(
          onTap: (index){
            if(snapshot.data[0]['ad'][index]['post_id'] != null){

              Navigator.pushNamed(context, '/startPost/${snapshot.data[0]['ad'][index]['post_id']}');
            }
            if(snapshot.data[0]['ad'][index]['shop_id'] != null){

              Navigator.pushNamed(context, '/startShop/${snapshot.data[0]['ad'][index]['shop_id']}');
            }
            if(snapshot.data[0]['ad'][index]['url'] != null){

              _goToUrl(snapshot.data[0]['ad'][index]['url']);
            }
          },
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: "https://www.mocatag.ir/uploads/picture/ad/${snapshot.data[0]['ad'][index]['title']}",
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      ),
                ),
              ),
              placeholder: (context, url) => Center(child: Padding(
                padding: const EdgeInsets.all(50),
                child: CircularProgressIndicator(),
              )),
              errorWidget: (context, url, error) => Icon(Icons.error),
            );

          },
          itemCount: snapshot.data[0]['ad'].length,
          pagination: SwiperPagination(),
          control: SwiperControl(),
        ),
      ),
    );
  }
}
