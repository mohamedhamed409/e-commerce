import 'package:shop_app/models/change_favorites_models.dart';
import 'package:shop_app/models/login_model.dart';

abstract class ShopLayoutStates{}
class ShopLayoutInitialStates extends ShopLayoutStates{}
class ShopLayoutChangeBottomNavStates extends ShopLayoutStates{}

class ShopLoadingHomeDataState extends ShopLayoutStates{}
class ShopSuccessHomeDataState extends ShopLayoutStates{}
class ShopErrorHomeDataState extends ShopLayoutStates{}
class ShopSuccessCategoryDataState extends ShopLayoutStates{}
class ShopErrorCategoryDataState extends ShopLayoutStates{}

class ShopSuccessChangeFavoritesState extends ShopLayoutStates
{
 late final ChangeFavoritesModel model;
 ShopSuccessChangeFavoritesState(this.model);
}
class ShopErrorChangeFavoritesState extends ShopLayoutStates {}

class ShopChangeFavoritesState extends ShopLayoutStates{}

class ShopLoadingGetFavoritesDataState extends ShopLayoutStates{}
class ShopSuccessGetFavoritesDataState extends ShopLayoutStates{}
class ShopErrorGetFavoritesDataState extends ShopLayoutStates{}

class ShopLoadingGetProfileDataState extends ShopLayoutStates{}
class ShopSuccessGetProfileDataState extends ShopLayoutStates{
 final ShopLoginModel model;
 ShopSuccessGetProfileDataState(this.model);
}
class ShopErrorGetProfileDataState extends ShopLayoutStates{}


class ShopLoadingUpdateDataState extends ShopLayoutStates{}
class ShopSuccessUpdateDataState extends ShopLayoutStates{
 final ShopLoginModel model;
 ShopSuccessUpdateDataState(this.model);
}
class ShopErrorUpdateDataState extends ShopLayoutStates{}



class ShopChangeThemeMode extends ShopLayoutStates{}