import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/login/cubit/states.dart';
import 'package:shop_app/modules/register/cubit/states.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

import '../../../shared/network/end_points.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopLoginModel? registerModel;//?!

  ShopRegisterCubit():super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context)=>BlocProvider.of(context);

  userRegister({required String email,
    required String password,
    required String name,
    required String phone})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: REGISTER,
      data:
    {
      'email':email,
      'password':password,
      'name':name,
      'phone':phone,
    },
    token: token,
    ).then((value)
    {
   //   print(value.data);
      registerModel= ShopLoginModel.fromJson(value.data);
      print('status of login model is >>>> ${registerModel!.status}');

      // print(loginModel.data!.token); it cause problem because token cannot be found in invalid login that lead to error state is done and
      print('message  ' + value.data['message']);
      emit(ShopRegisterSuccessState(registerModel!));
    }).catchError((error){
      print(error.toString());
      emit(ShopRegisterErrorState(error.toString()));
      print(error.toString());

    })
    ;
  }
  IconData suffix=Icons.visibility_outlined;
  bool isPassword=false;
  void changePasswordVisibility()
  {
    isPassword=!isPassword;
    suffix=isPassword?Icons.visibility_off_outlined:Icons.visibility_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }

}
