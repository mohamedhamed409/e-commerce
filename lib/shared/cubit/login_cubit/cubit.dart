import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../network/end_points.dart';
import '../../../view/login/cubit/states.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginModel? loginModel;//?!

 ShopLoginCubit():super(ShopLoginInitialState());

 static ShopLoginCubit get(context)=>BlocProvider.of(context);

 userLogin({required String email,required String password})
 {
  emit(ShopLoginLoadingState());
  DioHelper.postData(url: LOGIN, data:
  {
   'email':email,
   'password':password,
  },).then((value)
  {
   debugPrint(value.data);
   loginModel= ShopLoginModel.fromJson(value.data);
   debugPrint('status of login model is >>>> ${loginModel!.status}');

   // print(loginModel.data!.token); it cause problem because token cannot be found in invalid login that lead to error state is done and
   debugPrint(value.data['message']);
   emit(ShopLoginSuccessState(loginModel!));
  }).catchError((error){
   debugPrint(error.toString());
   emit(ShopLoginErrorState(error.toString()));
   debugPrint(error.toString());

  })
  ;
 }
 IconData suffix=Icons.visibility_outlined;
 bool isPassword=false;
 void changePasswordVisibility()
 {
  isPassword=!isPassword;
  suffix=isPassword?Icons.visibility_off_outlined:Icons.visibility_outlined;
  emit(ShopChangePasswordVisibilityState());

 }

}
