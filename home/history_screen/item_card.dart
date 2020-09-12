import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';
import 'transforms.dart';
import 'package:flip_card/flip_card.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ItemCard extends StatelessWidget {
  final List data;

  ItemCard(this.data);

  @override
  Widget build(BuildContext context) {
    var withOfTextBox = MediaQuery.of(context).size.width * 7 / 10;
    //
    return new TransformerPageView(
      loop: false,
      scrollDirection: Axis.vertical,
      //transformer: DeepthPageTransformer(),
      viewportFraction: 0.1,
      physics: BouncingScrollPhysics(),
      pageSnapping: true,
      //
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        var title = data[index]['title'];
        var id = data[index]['id'];
        var postId = data[index]['post_id'];
        var shopId = data[index]['shop_id'];
        var qrCode = data[index]['qr_code'];
        var count = data[index]['count'];
        var statusText = data[index]['status_text'];
        var statusCode = data[index]['status_code'];
        var totalPriceFormated = data[index]['total_price_formated'];
        var priceFormated = data[index]['price_formated'];
        var priceWithOffFormated = data[index]['price_withOff_formated'];
        var cDateShamsi = data[index]['c_date_shamsi'];
        var usedDateShamsi = data[index]['used_date_shamsi'];
        var sDateUseShamsi = data[index]['s_date_use_shamsi'];
        var eDateUseShamsi = data[index]['e_date_use_shamsi'];
        var lat = data[index]['lat'];
        var long = data[index]['long'];
        var shopName = data[index]['shop_name'];

        launchMap() async {
          var mapSchema = "geo:" + lat + "," + long + "?q=" + lat + "," + long;
          if (await canLaunch(mapSchema)) {
            await launch(mapSchema);
          } else {
            throw 'Could not launch $mapSchema';
          }
        }

        return FlipCard(
          //key: cardKey,
          front: Card(
            //key: cardKey,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
            child: Container(
                color: (statusCode == 1) ? Colors.lightGreen : Colors.redAccent,
                child: Container(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  width: withOfTextBox,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                          child: InkWell(
                        //onTap: () =>cardKey.currentState.toggleCard(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              shopName,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              ' مبلغ کل : ' + totalPriceFormated + ' تومان ',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'قیمت هر تگ با تخفیف : ' +
                                  priceWithOffFormated +
                                  ' تومان ',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'قیمت اصلی هر تگ  : ' + priceFormated + ' تومان ',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'تعداد : ' + count.toString() + " عدد ",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'تاریخ خرید : ' + cDateShamsi,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              'مهلت استفاده : از ' +
                                  sDateUseShamsi +
                                  "\n" +
                                  " الی " +
                                  eDateUseShamsi,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                            (usedDateShamsi != null)
                                ? Text(
                                    'تاریخ استفاده : ' + usedDateShamsi,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    overflow: TextOverflow.ellipsis,
                                  )
                                : Container(),
                            Text(
                              'وضعیت : ' + statusText,
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      )),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              color: Colors.white54,
                              height: 1,
                              width: double.infinity,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'دسترسی سریع',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/startShop/$shopId');
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'فروشگاه',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.store_mall_directory,
                                        color: Colors.white70,
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/startPost/$postId');
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'تگ',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.local_offer,
                                        color: Colors.white70,
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    launchMap();
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'نقشه',
                                        style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.white70,
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          back: Card(
            //key: cardKey,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            margin: EdgeInsets.only(top: 40, bottom: 40, left: 20, right: 20),
            child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: QrImage(
                        data: qrCode,
                        version: QrVersions.auto,
                        //size: 200.0,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'کد خرید : ' + qrCode,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.indigo,
                              fontWeight: FontWeight.bold),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'وضعیت : ' + statusText,
                          style: TextStyle(
                            fontSize: 15,
                            color:
                                (statusCode != 1) ? Colors.red : Colors.green,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    )
                  ],
                )),
          ),
        );
      },
    );
  }
}
