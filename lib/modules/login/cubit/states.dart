import 'package:shop_app/models/login_model.dart';

abstract class ShopLoginStates {}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates
{
  final ShopLoginModel modelLogin;
  ShopLoginSuccessState(this.modelLogin);
}

class ShopLoginErrorState extends ShopLoginStates{
  final String error;
  ShopLoginErrorState(this.error);
}
class ShopChangePasswordVisibilityState extends ShopLoginStates{}


