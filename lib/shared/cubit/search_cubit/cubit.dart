import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/search_model.dart';
import 'package:shop_app/shared/network/end_points.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../component/constants.dart';
import '../../../view/search/cubit/states.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit():super(SearchInitialState());
  static SearchCubit get(context)=>BlocProvider.of(context);
   SearchModel? searchModel;
  void search(String text)
  {
   emit(SearchLoadingState()) ;
    DioHelper.postData(
        url:SEARCH,
      token: token,
      data: {
      'text':text,
              },

    ).then((value)
    {
      searchModel = SearchModel.fromJson(value.data);
      print(value.data);

      emit(SearchSuccessState());
    }).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState());
    });
  }
}