import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/category_model.dart';

class CategoriesScreen extends StatelessWidget {

const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   // CategoryModel? categoryModel;
    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){},
      builder: (context,states){return ListView.separated(
          physics: BouncingScrollPhysics(),
          itemBuilder: (context,index)=>buildCatItem(
              ShopLayoutCubit.get(context).categoryModel!.data!.myData[index],
          ),//////////
          separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1,),
          itemCount: ShopLayoutCubit.get(context).categoryModel!.data!.myData.length);}
     ,
    );
  }

}

buildCatItem(CategoryData model)=>Padding(
  padding: const EdgeInsets.all(20.0),
  child:   Row(
    children: [
      Image(
        width: 80.0,height: 80.0,
        image: NetworkImage(model.image!),
        fit: BoxFit.cover,
      ),
      SizedBox(width:20.0,),
      Text(model.name!,style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold),),
      Spacer(),
      Icon(
        Icons.arrow_forward_ios,
      ),

    ],
  ),
);