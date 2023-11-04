import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class MainShopCubit extends Cubit<MainShopStates>
{
  MainShopCubit():super(MainShopInitialState());
static MainShopCubit get(context)=>BlocProvider.of(context);

bool isDark=false;
void changeAppMode({bool? fromShared})
{
  if(fromShared!=null)
  {
    isDark=fromShared;
    emit( MainShopChangeAppModeState());
  }else
  {
    isDark = !isDark;

    CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
      emit(MainShopChangeAppModeState());
    });
  }
}


}
