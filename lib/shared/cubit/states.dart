abstract class MainShopStates {}
class MainShopInitialState extends MainShopStates{}

class MainShopChangeAppModeState extends MainShopStates{}
class MainShopSearchLoadingState extends MainShopStates{}
class MainShopGetSearchSuccessState extends MainShopStates{}
class MainShopGetSearchErrorState extends MainShopStates
{
  late final  String error;
  MainShopGetSearchErrorState(this.error);
}