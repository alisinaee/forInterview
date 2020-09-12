import 'dart:io';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../http/http.dart';

Widget rightChild(BuildContext context, GlobalKey _innerDrawerKey, Key _keyRed,
    bool _position, double _width,String clientName, Function toggle) {
  Color textColor = Theme.of(context).primaryColorLight;
  Color iconColor = Theme.of(context).primaryColor;
  const double iconSize = 19;
  const double fontSizeAll = 12;
  TextStyle textStyleAll = TextStyle(
      fontSize: fontSizeAll, color: textColor, fontWeight: FontWeight.bold);
  SizedBox spaceIconText = SizedBox(
    width: 15,
  );
  SizedBox divider = SizedBox(
    height: 1,
    child: new Center(
      child: new Container(
        margin: new EdgeInsetsDirectional.only(start: 35, end: 25),
        height: 1,
        color: Theme.of(context).dividerColor,
      ),
    ),
  );

  _goToSupport() async {
    const url = 'https://www.mocatag.ir/تماس%20با%20موکاتگ';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _goToColl() async {
    const url = 'https://www.mocatag.ir/همکاری%20با%20موکاتگ';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _goToShoppingWay() async {
    const url = 'https://www.mocatag.ir/سوالات%20متداول';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _rulls() async {
    const url = 'https://www.mocatag.ir/قوانین%20خرید%20و%20ثبت%20نام';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  return Material(
      child: SafeArea(
          //top: false,
          child: Container(
    decoration: BoxDecoration(
      border: Border(
          left: BorderSide(width: 1, color: Colors.grey[200]),
          right: BorderSide(width: 1, color: Colors.grey[200])),
    ),
    child: Stack(
      key: _keyRed,
      children: <Widget>[
        ListView(
          children: <Widget>[
            InkWell(
              onTap: () => {toggle()},
              child: Container(
                  color: Theme.of(context).dividerColor,
                  padding: EdgeInsets.only(top: 12, bottom: 20, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 2, left: 15),
                        child: Icon(
                          Icons.arrow_forward,
                          color: textColor,
                          size: iconSize + 10,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            clientName,
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          SizedBox(
                            width: 22,
                            height: 22,
                            child: CircleAvatar(
                              child: Icon(Icons.person,
                                  color: iconColor, size: iconSize),
                              backgroundColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
            //Divider(),
            Container(
              //margin: EdgeInsets.only(top: 10 , right: 20 , left: 20),
              child: Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {Navigator.pushNamed(context, '/profile');},
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 30, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'حساب کاربری',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(Icons.person, color: iconColor, size: iconSize)
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: () {Navigator.pushNamed(context, '/city');},
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'انتخاب شهر',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.location_on,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'گزارش ایراد',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.bug_report,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: _goToSupport,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'پشتیبانی',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.headset_mic,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: _goToShoppingWay,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'روش خرید',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.loyalty,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: _goToSupport,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'ارتباط با ما',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.call,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: _rulls,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'قوانین',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.info_outline,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: () {
                      //check for update
                      Http http = Http();
                      http.checkForUpdate(context , 'drawer');
                      //end check
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'بروز رسانی',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.cloud_download,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: _goToColl,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'درخواست همکاری',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.work,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: () {
                      Http http = new Http();
                      http.setClientToken(null);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      Navigator.pushReplacementNamed(context, 'auth');
                    },
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10, right: 20, left: 20, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'خروج از حساب',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.exit_to_app,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                  divider,
                  InkWell(
                    onTap: () {exit(0);},
                    child: Container(
                      margin:
                      EdgeInsets.only(top: 15, right: 20, left: 20, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            'خروج از برنامه',
                            style: textStyleAll,
                          ),
                          spaceIconText,
                          Icon(
                            Icons.power_settings_new,
                            color: iconColor,
                            size: iconSize,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

      ],
    ),
  )));
}
