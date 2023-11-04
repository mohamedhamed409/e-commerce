import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/shared/component/component.dart';
// import 'package:shop_app/shared/network/end_points.dart';
// import 'package:shop_app/shared/network/local/cache_helper.dart';
// import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../models/category_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
        listener:(context,state){
          if(state is ShopSuccessChangeFavoritesState)
          {
if(!state.model.status)
{
  showToast(text: state.model.message, state: ToastStates.error);

}
          }

        } ,
        builder:(context,state){
          return ConditionalBuilder(

              condition: ShopLayoutCubit.get(context).homeModel!=null&&ShopLayoutCubit.get(context).categoryModel!=null,
              builder: (context)=>productsBuilder(ShopLayoutCubit.get(context).homeModel!,ShopLayoutCubit.get(context).categoryModel!,context),
              fallback: (context)=>Center(child: CircularProgressIndicator(),),
          );}
    );

  }
  Widget productsBuilder(HomeModel model,CategoryModel categoryModel,context)=>SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          items:model.data!.banners.map((e) => Image(
          image: NetworkImage('${e.image}'),
          width: double.infinity,
          fit: BoxFit.cover,
        ), ).toList(),
            options: CarouselOptions(
              height: 250.0,
              initialPage:0,
              viewportFraction:1.0 ,//to make image fit and not overlap
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval:Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve:Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            ),),
        SizedBox(height: 10.0,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal:10.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',style: TextStyle(
                  fontSize: 24.0,fontWeight: FontWeight.w800),
              ),
              SizedBox(height: 10.0,),
              Container(height: 100.0,
       child: ListView.separated(
               physics: BouncingScrollPhysics(),
                 scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                 itemBuilder: (context,index)=>buildCategoryItem(categoryModel.data!.myData[index]),
                 separatorBuilder: (context,index)=>SizedBox(
                   width:10 ,height: 1.0,),
                 itemCount: categoryModel.data!.myData.length),
     ) ,
              SizedBox(height: 20.0,),
              Text(
                'New Products',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.w800),),
            ],
          ),
        ),

        Container(
       //   color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 1.0,
            childAspectRatio: 1/1.72,
            physics: NeverScrollableScrollPhysics(),

            children: List.generate(model.data!.products.length,
                  (index) => buildGridProduct(model.data!.products[index],context),
            ),
          ),
        ),
      ],
    ),
  );


  Widget buildCategoryItem(CategoryData model)=>  Stack(alignment: Alignment.bottomCenter,
    children: [
      Image(
        height: 100,width:100,
        image: NetworkImage(
          model.image!,
        ),
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8),
        width: 100,
        child: Text(textAlign:TextAlign.center,
          maxLines:1,
          overflow:TextOverflow.ellipsis,
          model.name!,style: TextStyle(
            // fontWeight: FontWeight.w800,
            color: Colors.white,

          ),
        ),
      ),
    ],
  );
  Widget buildGridProduct(ProductModel model,context)=> Container(
    //color: Colors.white, //the color is already white
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model.image),
              width: double.infinity,
              height: 200,//error is disappear  when we put height to image Regardless the number of height 70,100,200 all true
              // fit: BoxFit.cover,
            ),
            if(model.discount!=0)
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
        Padding(
          padding: const EdgeInsets.all(01),//12
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(height: 1.3,fontSize: 14),
              ),
              Row(
                children: [
                  Text(
                    'Price: ${model.price.round()}',//.round() if the coming number is double it will convert it to int number
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize:12,color: defaultColor),
                  ),
                  SizedBox(
                    width: 5.0,),
                  if(model.discount!=0)
                  Text(
                    'Price: ${model.oldPrice.round()}',//.round() if the coming number is double it will convert it to int number
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
                      ShopLayoutCubit.get(context).changeFavorites(model.id);
                      //  ShopLayoutCubit.get(context).favorites={model.id:model.inFavorites};
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopLayoutCubit.get(context).favorites[model.id]!?defaultColor:Colors.grey,
                      radius: 15.0,
                        child: Icon(Icons.favorite_border,size: 14.0,color: Colors.white,),),),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

}
