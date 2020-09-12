import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import '../../http/http.dart';
import '../no_internet.dart';
import 'search_result.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen(Key key) : super(key : key);

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  Http http = Http();
  bool isSearching = false;
  String text;
  int category;
  String categoryText;
  //
  void rebuild(){
    setState(() {

    });
  }
  void searching(String _text, int _category ,bool permision)
  {
    setState(() {
      isSearching = false;
    });
    if (_text != null && permision == true ) {
      setState(() {
        text =_text;
        category = _category;
        switch(category){
          case 0:
            categoryText = 'همه ی تگ ها';
            break;

          case 2:
            categoryText = 'رستوران و کافی شاپ';
            break;

          case 3:
            categoryText = 'تفریحی ورزشی';
            break;

          case 5:
            categoryText = 'زیبایی آرایشی';
            break;

          case 6:
            categoryText = 'خدمات';
            break;

          case 1:
            categoryText = 'کالا';
            break;

          case 11:
            categoryText = 'سایر تخفیف ها';
            break;
        }
        isSearching = true;
      });
    } else{
      setState(() {
        isSearching = false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    //

    if ((isSearching == false)) {
      return Container(
        padding: EdgeInsets.all(50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'برای جستجو ابتدا دسته بندی دلخواه خود را انتخاب کنید ، سپس با وارد کردن عبارت مورد نظر  بروی ',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            Icon(
              Icons.search,
              size: 22,
              color: Colors.deepPurple,
            ),
            Text(
              'کلیک کنید. ',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {

      return FutureBuilder(
          future: http.search(text, category),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SearchResult(snapshot.data ,categoryText , text);
            } else if (snapshot.hasError) {
              return NoInternet(rebuild);
            }

            return Center(
              child: Container(

                width: MediaQuery.of(context).size.width*9/10,
                height: MediaQuery.of(context).size.width*9/10,
                child: FlareActor("assets/flr/loading.flr", alignment:Alignment.center, fit:BoxFit.contain, animation:"loading",shouldClip: false ),
              ),
            );
          });
    }
  }
}

