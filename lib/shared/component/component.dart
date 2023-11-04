import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/modules/login/cubit/cubit.dart';
import 'package:shop_app/modules/webview_screen.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../models/get_favoritesmodel.dart';
import '../../modules/register/cubit/cubit.dart';


Widget defaultTextFormField({
  context,
  required TextEditingController controller,
  required TextInputType type,
  // required Function onSubmit(val),
  // required Function onChane,
  GestureTapCallback ?onTap,
  required String label,
  required IconData prefix,
  IconData ?suffix,
  Widget?suffixOnPressed,//i added it
  bool isPassword=false,
  required FormFieldValidator validate,
  bool isClickable=true,
  ValueChanged? onChange,
  ValueChanged<String>?onSubmit,

//  Function?onChange,
}
    )=>  TextFormField(

  onFieldSubmitted: onSubmit,
  onChanged:onChange ,
  onTap: onTap,
  enabled: isClickable,
  validator: validate,
  controller: controller,
  obscureText:isPassword,
  keyboardType:type ,

  // onFieldSubmitted:(val){onSubmit(val);},
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(prefix,),
      suffixIcon: suffixOnPressed,//i add this because it can't take two phases of cubit one of logincubit and registercubit it take on of them only
    border: OutlineInputBorder(),//complete above line >> it will take first cubit and ignore second cubit
  ),
  //  border: InputBorder.none,

);

void navigateTo(context,widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget,));

Widget buildArticleItem(article,context)=>InkWell(
  onTap: ()
  {
    navigateTo(context, WebViewScreen(article['url']));
  },
  child:   Padding  (
    padding: const EdgeInsets.all(20.0),
    child: Row(children: [
      Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(image: NetworkImage(
              '${article['urlToImage']}'),
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 20.0,),
      Expanded(
        child: Container(height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
  
              Expanded(
                child:  Text(
                  '${article['title']}'
                  ,
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text('${article['publishedAt']}',style: TextStyle(),),
            ],),
        ),
      ),
  
    ],
    ),
  ),
);

Widget articleBuilder(list,context,{isSearch=false})=>  ConditionalBuilder(condition: (list.length>0),
  builder: (context)=>ListView.separated(
    physics:const BouncingScrollPhysics(),
    itemBuilder: (context,index)=>buildArticleItem(list[index],context),
    separatorBuilder: (context,index)=>Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0,),
      child: Container(width: double.infinity,height: 2.0,color: Colors.white60,),
    ),
    itemCount: 10,),
  fallback: (context)=>isSearch?Container():Center(child: CircularProgressIndicator()),);

void navigateAndFinish(context,widget)=>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context)=>widget),
            (route) => false);

Widget defaultButton({
  required VoidCallback function,
  required String text,
 // Color? myColor,
  bool isNotUpperCase=false,
}
)=>MaterialButton(

  onPressed: function,
  //color:myColor ,
  color: defaultColor,
  height: 50,
  minWidth:double.infinity,
  child:isNotUpperCase?Text(text):Text(text.toUpperCase()),

);

Widget defaultTextButton
    ({required VoidCallback function,
      required String text,})
=>TextButton(onPressed: function, child: Text(text.toUpperCase()),);
void showToast({required String text,required ToastStates state})=>
Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0);
enum ToastStates
{
  success,
  warning,
  error,
}
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.success:
      color=Colors.green;
      break;
    case ToastStates.warning:
      color=Colors.amber;
      break;
    case ToastStates.error:
      color=Colors.red;
      break;
  }
  return color;

}

Widget buildListItem( model,context,{bool isOldPrice=true})=> Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image!),
              width: 120,fit: BoxFit.cover,
              height: 120,//error is disappear  when we put height to image Regardless the number of height 70,100,200 all true
              // fit: BoxFit.cover,
            ),
            if(model.discount!=0 && isOldPrice)
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal:5.0,),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(fontSize:8.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3,fontSize: 14),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    'Price: ${model.price.toString()}',//.round() if the coming number is double it will convert it to int number
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize:12,color: defaultColor),
                  ),
                  SizedBox(
                    width: 5.0,),
                  if(model.discount!=0 && isOldPrice)
                    Text(
                      'Price: ${model.oldPrice.toString()}',//.round() if the coming number is double it will convert it to int number
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize:10,
                          color: Colors.red,//in video his choice was grey
                          decoration:TextDecoration.lineThrough),
                    ),
                  Spacer(),
                  IconButton(
                    //  padding:EdgeInsets.zero,
                    onPressed: (){
                      // print(ShopLayoutCubit.get(context).favorites);
                      ShopLayoutCubit.get(context).changeFavorites(model.id!);
                      //  ShopLayoutCubit.get(context).favorites={model.id:model.inFavorites};
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopLayoutCubit.get(context).favorites[model.id]! ?defaultColor:Colors.grey,
                      radius: 15.0,
                      child: Icon(Icons.favorite_border,size: 14.0,color: Colors.white,),),),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);
