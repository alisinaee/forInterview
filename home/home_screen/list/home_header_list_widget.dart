import 'package:flutter/material.dart';


Widget headerList(BuildContext context,String title , String img)
{
  double width = MediaQuery.of(context).size.width;
  return Container(

    color: Theme.of(context).scaffoldBackgroundColor,
    padding: EdgeInsets.only(top: 15 , bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(title , style: TextStyle(color: Theme.of(context).accentColor , fontWeight: FontWeight.bold , fontSize: 14),),
        SizedBox(width: 10,),
        Container(
          width: width/22,
            child: Image.asset(img , fit: BoxFit.fill,color: Theme.of(context).primaryColor,)
        )
      ],

    ),
  );
}