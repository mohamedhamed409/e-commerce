import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/view/login/shop_login_screen.dart';
import 'package:shop_app/view/search/search_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopLayoutCubit, ShopLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit=ShopLayoutCubit.get(context);
          return Scaffold(
          appBar: AppBar
            (
            title:Text(
              'SALA',
            ),
            actions: [
              IconButton(onPressed: (){navigateTo(context, SearchScreen());}, icon:Icon(Icons.search),),
              IconButton(onPressed: (){
                ShopLayoutCubit.get(context).changeAppMode();
              },
                  icon: Icon(Icons.ac_unit_outlined,)),
            ],
          ),
          body: cubit.bottomScreen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              onTap: (index){cubit.changeBottom(index);},
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Products'),
                BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),


              ],
            ),
            
        );
        }
    );
  }
}
