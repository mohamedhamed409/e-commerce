import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/modules/login/shop_login_screen.dart';
import 'package:shop_app/modules/onboard_screen/onboard_screen.dart';
import 'package:shop_app/shared/bloc_observer.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/shop_app/home_layout.dart';
import 'shared/cubit/cubit.dart';
import 'shared/cubit/states.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark=CacheHelper.getData(key:'isDark');
  Widget?widget;
  bool? onBoarding=CacheHelper.getData(key:'onBoarding');
  token=CacheHelper.getData(key:'token');print(token);//the problem was here i wrote String?
if(onBoarding!=null)
{
  if(token!=null)
  {
    widget = ShopLayout();
  }
  else
  {
    widget=ShopLoginScreen();
  }
}else{widget=OnBoardScreen();}

  print('is boarding $onBoarding');
  print('is dark $isDark');
runApp(MyApp(
    isDark:isDark,
    startWidget:widget,
));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;
  const MyApp({this.isDark,this.startWidget, super.key});

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context)=>MainShopCubit()..changeAppMode(
        fromShared:isDark,),),
        BlocProvider(create: (BuildContext context)=>ShopLayoutCubit()..getHomeData()..getCategoryData()..getFavoritesData()..getProfileData(),
        ),
      ],

        //you don't need to use the following because we use NewsCubit() only
        // if we use AppCubit() we will use MultiBlocProvider


        // MultiBlocProvider(providers: [
        //    BlocProvider(
        //      create: (BuildContext context)=>NewsCubit()..getBusiness(),),
        //    BlocProvider(
        //      create: (BuildContext context)=>NewsCubit()..changeAppMode(
        //        fromShared:isDark,),
        //    ),
        // ],);

        child:
        BlocConsumer<MainShopCubit,MainShopStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: !isDark!?darkTheme:lightTheme,
              darkTheme:darkTheme,
              themeMode:ThemeMode.light,//NewsCubit.get(context).isDark?ThemeMode.dark:ThemeMode.light
              home:startWidget,

            );},
          //),

        ),
    );
  }
}