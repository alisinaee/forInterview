import 'package:flutter/material.dart';

class AppBarCategoryWidget extends StatefulWidget {
  final Function change;

  AppBarCategoryWidget(Key key, this.change) : super(key: key);

  @override
  AppBarCategoryWidgetState createState() => AppBarCategoryWidgetState();
}

class AppBarCategoryWidgetState extends State<AppBarCategoryWidget> {
  bool _1 = false;
  bool _2 = false;
  bool _3 = false;
  bool _4 = false;
  bool _5 = false;
  bool _6 = false;
  bool _0 = false;
  bool _11 = false;

  void select(int index) {
    if (index == -1) {
      index = 0;
    }
    else if (index == -2) {

    } else {
      widget.change(index);
    }

    setState(() {
      _1 = false;
      _2 = false;
      _3 = false;
      _4 = false;
      _5 = false;
      _6 = false;
      _0 = false;
      _11 = false;
      //
      switch (index) {
        case 1:
          _1 = true;
          break;

        case 2:
          _2 = true;
          break;

        case 3:
          _3 = true;
          break;

        case 4:
          _4 = true;
          break;

        case 5:
          _5 = true;
          break;

        case 6:
          _6 = true;
          break;

        case 0:
          _0 = true;
          break;

        case 11:
          _11 = true;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: ListView(
        reverse: true,
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          categoryItem(
              context, 'همه ی تگ ها', 'assets/images/c8.png', _0, 0, select),
          categoryItem(context, 'رستوران و کافی شاپ', 'assets/images/c2.png',
              _2, 2, select),
          categoryItem(
              context, 'تفریحی ورزشی', 'assets/images/c3.png', _3, 3, select),
          categoryItem(
              context, 'زیبایی آرایشی', 'assets/images/c4.png', _5, 5, select),
          categoryItem(context, 'خدمات', 'assets/images/c5.png', _6, 6, select),
          categoryItem(context, 'کالا', 'assets/images/c7.png', _1, 1, select),
          categoryItem(context, 'سایر تخفیف ها', 'assets/images/c1.png', _11,
              11, select),
        ],
      ),
    );
  }
}

Widget categoryItem(BuildContext context, String title, String img,
    bool isSelect, int id, Function select) {
  double width = MediaQuery.of(context).size.width;
  return InkWell(
    onTap: () {
      select(id);
    },
    child: Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 6, bottom: 6),
      padding: EdgeInsets.all(10),
      decoration: new BoxDecoration(
          color:
              (isSelect == true) ? Colors.deepPurple[300] : Colors.transparent,
          borderRadius: new BorderRadius.all(
            const Radius.circular(40.0),
          )),

      //padding: EdgeInsets.only(left: 15 ,right: 15 ,bottom: 10 ,top: 15),
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              width: width * 1 / 25,
              child: Image.asset(
                img,
                fit: BoxFit.fill,
                color: (isSelect == true)
                    ? Colors.white70
                    : Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                color: (isSelect == true)
                    ? Colors.white
                    : Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
