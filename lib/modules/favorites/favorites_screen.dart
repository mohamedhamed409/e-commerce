import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/get_favoritesmodel.dart';
import 'package:shop_app/shared/component/component.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';

import '../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
          condition:(state is! ShopLoadingGetFavoritesDataState) ,
          builder: (context)=>  ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>buildListItem(ShopLayoutCubit.get(context).favoritesModel!.data!.data2[index].product!,context),
              separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1,),
              itemCount: ShopLayoutCubit.get(context).favoritesModel!.data!.data2.length),
          fallback: (context)=>Center(child: CircularProgressIndicator()),

        );}
      ,
    );
  }
}
