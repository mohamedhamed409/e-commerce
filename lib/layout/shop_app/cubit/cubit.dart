import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/change_favorites_models.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/view/categories/categories_screen.dart';
import 'package:shop_app/view/favorites/favorites_screen.dart';
import 'package:shop_app/view/products/products_screen.dart';
import 'package:shop_app/view/settings/settings_screen.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../../models/category_model.dart';
import '../../../models/get_favoritesmodel.dart';
import '../../../shared/network/end_points.dart';

class ShopLayoutCubit extends Cubit<ShopLayoutStates>
{
  ShopLayoutCubit():super(ShopLayoutInitialStates());
  static ShopLayoutCubit get(context)=>BlocProvider.of(context);
  int currentIndex=0;
  List<Widget>bottomScreen=
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
void changeBottom(int index)
{
  currentIndex=index;
  emit(ShopLayoutChangeBottomNavStates());
}
 HomeModel? homeModel;
 Map<int,bool>favorites={};
void getHomeData()
{
  emit(ShopLoadingHomeDataState());
  DioHelper.getData(
    url: HOME,
    token:token,
  ).then((value)
  {
    homeModel=HomeModel.fromJson(value.data);
    homeModel!.data!.products.forEach((element) {
      favorites.addAll({
        element.id:element.inFavorites,
      });
    });
    print('Favorite is >>> ${favorites.toString()}');
   // homeModel=HomeModel.fromJson(value.data);
   // printFullText(homeModel.toString());
     // printFullText(homeModel!.data.banners[0].image);
    //  print(homeModel!.status);
    emit(ShopSuccessHomeDataState());
  }).catchError((error){
    print(error.toString());
    emit(ShopErrorHomeDataState());
  });

}
  CategoryModel? categoryModel;
  void getCategoryData()
  {

    DioHelper.getData(
      url: CATEGORIES,
    ).then((value)
    {
      categoryModel=CategoryModel.fromJson(value.data);
      // printFullText(homeModel.toString());
      print(categoryModel!.status);
      emit(ShopSuccessCategoryDataState());
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorCategoryDataState());
    });

  }
  ChangeFavoritesModel? changeFavoritesModel;
  void changeFavorites(int productId)
  {
    favorites[productId]=!favorites[productId]!;
emit(  ShopChangeFavoritesState());
    DioHelper.postData(url: FAVORITES,
  data:{'product_id':productId,},
  token: token,/////////constants
).then((value){

  changeFavoritesModel=ChangeFavoritesModel.fromJson(value.data);
print(value.data);
if(!changeFavoritesModel!.status)
{
  favorites[productId]=!favorites[productId]!;
}else
{
  getFavoritesData();
}
  emit(  ShopSuccessChangeFavoritesState(changeFavoritesModel!));
}).catchError((error){
  emit(ShopErrorChangeFavoritesState());
    });
  }
   FavoritesModel? favoritesModel;//if you make it late there will be an error lateinitialization error
  void getFavoritesData()
  {
  emit(ShopLoadingGetFavoritesDataState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,

    ).then((value)
    {
      favoritesModel=FavoritesModel.fromJson(value.data);

      printFullText(value.data);

      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error){
      print('THe Error is '+error.toString());
      emit(ShopErrorGetFavoritesDataState());
    });

  }

  ShopLoginModel? profileModel;
  void getProfileData()
  {
    emit(ShopLoadingGetProfileDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
   profileModel=ShopLoginModel.fromJson(value.data);
    // print('abcdefg');
    //   printFullText(profileModel!.data!.name!);

      emit(ShopSuccessGetProfileDataState(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorGetProfileDataState());
    });

  }

  void updateData({
  required String myName,
    required String myEmail,
    required String myPhone,


  })
  {
    emit(ShopLoadingUpdateDataState());
    DioHelper.put(
      url: UPDATE_PROFILE,
      token: token,
      data:
    {
'name':myName, 'email':myEmail,'phone':myPhone,
    },
    ).then((value)
    {
      profileModel=ShopLoginModel.fromJson(value.data);
   //   print('abcdefg');
   //   printFullText(profileModel!.data!.name!);

      emit(ShopSuccessUpdateDataState(profileModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopErrorUpdateDataState());
    });

  }
  bool val=true;
  void changeAppMode()
  {
    val=!val;
    emit(ShopChangeThemeMode());
  }

}
