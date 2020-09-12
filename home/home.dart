import 'dart:io';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../http/http.dart';
import '../navigation_bar/navigation_bar_item.dart';
import '../navigation_bar/navigation_bar.dart';
import 'package:mocatag/home/home_screen/drawer/drawer_items.dart';
import 'appbar/appBarFloat.dart';
import 'appbar/appbarCategory.dart';
import 'history_screen/start_history.dart';
import 'home_screen/home_widget.dart';
import 'like_screen/start_like.dart';
import 'search_screen/search_screen.dart';
import 'shop_screen/start_shop_main.dart';
import 'package:badges/badges.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static GlobalKey<SearchScreenState> globalKey =
      GlobalKey<SearchScreenState>();
  final GlobalKey<AppBarCategoryWidgetState> categoryKey =
      GlobalKey<AppBarCategoryWidgetState>();
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  GlobalKey _keyRed = GlobalKey();
  double _width = 10;
  bool _position = true;
  int currentIndex = 2;
  TextEditingController searchController = TextEditingController();
  int categoryId;
  bool startSearch = false;
  var focusNode = new FocusNode();
  String clientName = 'کاربر مهمان';
  bool checkName = false;
  Http http = Http();
  //appbar bool to fixed in search
  bool appBarShow = true;
  FocusNode sb = new FocusNode();

  //search var
  //
  List<Widget> _widgetOptions = <Widget>[
    StartHistory(),
    StartLike(),
    HomeWidget(),
    SearchScreen(globalKey),
    StartShop(),
  ];

  @override
  void initState() {
    super.initState();
    //check for update
    Http http = Http();
    http.checkForUpdate(context ,'main');
    //end check
    _getwidthContainer();
  }

  @override
  void dispose() {
    super.dispose();
    _getwidthContainer();
  }

  void _getwidthContainer() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final keyContext = _keyRed.currentContext;
      if (keyContext != null) {
        final RenderBox box = keyContext.findRenderObject();
        final size = box.size;
        setState(() {
          _width = size.width;
        });
      }
    });
  }

  void _toggle() {
    _innerDrawerKey.currentState.toggle(
        // direction is optional
        // if not set, the last direction will be used
        direction: InnerDrawerDirection.end);
  }

  void selectCategory(int index) {
    //if we are in search screen and we select category
    if (currentIndex == 3) {
      categoryId = index;
      if (searchController.text.isNotEmpty) {
        globalKey.currentState.searching(searchController.text, index, true);
      } else {
        globalKey.currentState.searching(' ', index, true);
      }
    }

    //if we are not in search screen => go to search screen
    if (currentIndex != 3) {
      setState(() {
        startSearch = true;
        categoryId = index;
        currentIndex = 3;
      });
    }
  }

  /*void keyBordSubmit(String text) {

    if (currentIndex == 3) {
      globalKey.currentState.searching(text, categoryId, true);
    }

  }*/

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) =>  AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        content:  Container(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 5 / 10,
                height: MediaQuery.of(context).size.width * 5 / 10,
                child: FlareActor("assets/flr/error.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                    animation: "action"),
              ),
              Text('آیا می خواهید خارج شوید؟' ,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black87),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.purple,
                        width: 1,
                        style: BorderStyle.solid
                    ), borderRadius: BorderRadius.circular(5)),
                    onPressed: () => Navigator.of(context).pop(false),
                    child:  Text('خیر'),
                  ),
                  FlatButton(
                    shape: RoundedRectangleBorder(side: BorderSide(
                        color: Colors.purple,
                        width: 1,
                        style: BorderStyle.solid
                    ), borderRadius: BorderRadius.circular(5)),
                    onPressed: () {exit(0);},
                    child:  Text('بله'),
                  ),
                  //SizedBox(width: 50,),
                ],
              ),
            ],
          ),
        ),

      ),
    ) ?? false;
  }

  @override
  Widget build(BuildContext context) {


    FlutterStatusbarcolor.setStatusBarColor(
        Theme.of(context).scaffoldBackgroundColor);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    //
    //if we are just go in search screen from another one
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      if (currentIndex == 3) {
        globalKey.currentState.searching(' ', categoryId, startSearch);
      }
      if(checkName == false){
        checkName=true;
        //
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var token = prefs.getString('ClientToken')?? null;
        if(token != null){
          var hold = await http.clientName(token);
          setState(() {
            clientName = hold;
          });
        }
      }


    });

    return InnerDrawer(
        key: _innerDrawerKey,
        tapScaffoldEnabled: false,
        onTapClose: true,
        // default false
        swipe: true,
        // default true
        //colorTransition: Colors.red,
        // default Color.black54
        innerDrawerCallback: (a) => print(a),
        // return bool
        leftOffset: 0.1,
        // default 0.4
        rightOffset: 0.1,
        // default 0.4
        leftAnimationType: InnerDrawerAnimation.static,
        // default static
        rightAnimationType: InnerDrawerAnimation.linear,
        // default static
        rightChild: rightChild(
            context, _innerDrawerKey, _keyRed, _position, _width,clientName, _toggle),
        scaffold: WillPopScope(
          onWillPop: _onWillPop,
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder: (context, isInnerBoxScroll) {
                    return [
                      RoundedFloatingAppBar(
                        elevation: 4,
                        actions: <Widget>[
                          //0
                          InkWell(
                            onTap: () {},
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 2, top: 10, bottom: 10),
                              child: Icon(
                                Icons.notifications,
                                size: 19,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                          //1
                          Expanded(
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: TextField(
                                      onTap: () {
                                        if (currentIndex != 3) {
                                          categoryKey.currentState.select(-1);
                                          setState(() {
                                            currentIndex = 3;
                                            categoryId = 0;
                                          });
                                        }
                                      },
                                      focusNode: sb,
                                      textInputAction: TextInputAction.search,
                                      keyboardType: TextInputType.text,
                                      onSubmitted: (String txt) async{
                                        //keyBordSubmit(txt);

                                         FocusScope.of(context).requestFocus(focusNode);

                                        Future.delayed(const Duration(milliseconds: 500), () {

                                          if (currentIndex == 3) {
                                            globalKey.currentState.searching(txt, categoryId, true);
                                          }
                                        });

                                      },
                                      //focusNode: focusNode,
                                      textAlign: TextAlign.start,
                                      textDirection: TextDirection.rtl,
                                      controller: searchController,
                                      style: TextStyle(fontSize: 13),
                                      //onChanged: (v) => nameController.text = v,
                                      decoration: InputDecoration(
                                        suffixIcon: InkWell(
                                          onTap:(){

                                            FocusScope.of(context).requestFocus(focusNode);
                                            Future.delayed(const Duration(milliseconds: 500), () {
                                              if (currentIndex == 3) {
                                                globalKey.currentState.searching(searchController.text, categoryId, true);
                                              }
                                            });
                                          } ,
                                          child: Icon(
                                            Icons.search,
                                            size: 19,
                                            color: Colors.deepPurple,
                                          ),
                                        ),
                                        focusedBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        enabledBorder: new UnderlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.transparent),
                                        ),
                                        hintText: 'جستوجو در تگ ها',
                                        hintStyle: TextStyle(
                                            fontSize: 11, color: Colors.grey),
                                      )),
                                ),
                              ),
                            ],
                          )),
                          //2
                          (http.shopCard.length == 0)
                              ? IconButton(
                                  icon: Icon(
                                    Icons.shopping_cart,
                                    size: 19,
                                    color: Colors.deepPurple,
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/startShopCard');
                                  },
                                )
                              : Badge(
                                  badgeColor: Colors.red,
                                  shape: BadgeShape.circle,
                                  borderRadius: 20,
                                  toAnimate: true,
                                  position:
                                      BadgePosition.topRight(top: 3, right: 1),
                                  badgeContent: Text(
                                      http.shopCard.length.toString(),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 9)),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.shopping_cart,
                                      size: 19,
                                      color: Colors.deepPurple,
                                    ),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, '/startShopCard');
                                    },
                                  ),
                                ),

                          //3
                          IconButton(
                            icon: Icon(
                              Icons.menu,
                              size: 19,
                              color: Colors.deepPurple,
                            ),
                            onPressed: _toggle,
                          ),
                          //4
                          AppBarCategoryWidget(categoryKey, selectCategory),
                        ],
                        //automaticallyImplyLeading: true,
                        iconTheme: IconThemeData(
                          color: Colors.black,
                        ),
                        textTheme: TextTheme(
                          title: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        floating: appBarShow,
                        snap: appBarShow,
                        pinned: !appBarShow,

                        //pinned: false,
                        title: Column(
                          children: <Widget>[],
                        ),
                        backgroundColor:
                            Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ];
                  },
                  body: _widgetOptions.elementAt(currentIndex),
                ),
              ),
              bottomNavigationBar: TitledBottomNavigationBar(
                  reverse: true,
                  inactiveColor: Theme.of(context).accentColor,
                  activeColor: Theme.of(context).primaryColor,
                  indicatorColor: Theme.of(context).accentColor,
                  //curve :Curves.easeOutSine,

                  currentIndex: currentIndex,
                  // Use this to update the Bar giving a position
                  onTap: (index) {
                    if (currentIndex != index) {
                      setState(() {
                        if (index != 3) {
                          categoryKey.currentState.select(-2);
                          searchController.clear();
                          FocusScope.of(context).unfocus();
                          categoryId = 0;
                          appBarShow = true;
                        }
                        if (index == 3) {
                          categoryKey.currentState.select(-1);
                          startSearch = false;
                          appBarShow = false;
                        }
                        currentIndex = index;
                      });
                    }
                  },
                  items: [
                    TitledNavigationBarItem(title: 'سوابق', icon: Icons.history),
                    TitledNavigationBarItem(
                        title: 'علاقه مندی', icon: Icons.favorite),
                    TitledNavigationBarItem(title: 'خانه', icon: Icons.home),
                    TitledNavigationBarItem(title: 'جستجو', icon: Icons.search),
                    TitledNavigationBarItem(
                        title: 'مراکز', icon: Icons.store_mall_directory),
                  ])

              //endDrawer: Drawer(),
              ),
        ));
  }
}
