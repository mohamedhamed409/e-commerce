//https://newsapi.org/v2/everything?q=Apple&apiKey=API_KEY

import 'package:flutter/material.dart';

import '../../view/login/shop_login_screen.dart';
import '../network/local/cache_helper.dart';
import 'component.dart';

void signOut(context)
{
  TextButton(
    onPressed:()
    {
      CacheHelper.removeData(key: 'token',
      ).then((value){
        if(value) {
          navigateAndFinish(context, ShopLoginScreen());
        }
      });
    },
    child:const Text('SIGN OUT'),
  );
}

void logOut(context)
{

      CacheHelper.removeData(key: 'token',
      ).then((value){
        if(value) {
          navigateAndFinish(context, ShopLoginScreen());
        }
      });


}

void printFullText(String text)
{
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match)=>print(match.group(0)));
}
String? token='';