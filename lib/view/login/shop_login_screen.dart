import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/home_layout.dart';
import 'package:shop_app/shared/cubit/login_cubit/cubit.dart';
import 'package:shop_app/view/register/register_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/component/constants.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

import '../../shared/cubit/login_cubit/states.dart';

class ShopLoginScreen extends StatelessWidget {
   ShopLoginScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
        listener: (BuildContext context, state) {
          if(state is ShopLoginSuccessState)
          {
            if(state.modelLogin.status)// A nullable expression can't be used as a condition
                {
              print(state.modelLogin.status);
              print(state.modelLogin.data!.token);
              token=state.modelLogin.data!.token;//we write it lately to save token
              CacheHelper.saveData(key: 'token',
                  value: state.modelLogin.data!.token,
              ).then((value){
                navigateAndFinish(context,
                 const ShopLayout(),
                );
              });
              showToast(text: state.modelLogin.message!, state: ToastStates.success);
            }else{
              //print(state.modelLogin.status);
             // print(state.modelLogin.message);
                showToast(text: state.modelLogin.message!, state: ToastStates.error);
            }
          }

        },
        builder: (BuildContext context, Object? state) {

          return    Scaffold(
          appBar: AppBar(),
          body:Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold,color: Colors.black),

                      ),
                      Text(
                        'login now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                     const SizedBox(height: 30,),
                      defaultTextFormField(

                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: 'Email Address',
                          prefix: Icons.email,
                          validate: (val)
                          {
                            if(val.isEmpty)
                            {
                              return 'please enter email address';
                            }return null;
                          }),
                      const  SizedBox(height: 15,),
                      defaultTextFormField(
                        context:context,
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        label: 'Password',
                        prefix: Icons.lock_outlined,
                        onSubmit: (value)
                        {
                          if(formKey.currentState!.validate())
                          {
                            ShopLoginCubit.get(context).userLogin(email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        isPassword: ShopLoginCubit.get(context).isPassword,
                        suffix: ShopLoginCubit.get(context).suffix ,
                        suffixOnPressed: IconButton(icon: Icon(ShopLoginCubit.get(context).suffix),
                          onPressed: ()
                          {
                            ShopLoginCubit.get(context).changePasswordVisibility();

                          },
                        ),
                        validate: (val)
                        {
                          if(val.isEmpty)
                          {
                            return 'please enter password';
                          }return null;
                        },

                      ),
                      const SizedBox(height: 15.0,),
                     ConditionalBuilder(condition: state is! ShopLoginLoadingState,
                         builder: (context)=>  defaultButton(function: ()
                         {
                           if(formKey.currentState!.validate())
                         {
                           ShopLoginCubit.get(context).userLogin(email: emailController.text,
                               password: passwordController.text);
                         }

                         },
                           text:'login',
                        //   myColor: defaultColor,
                         ),

                         fallback: (context)=>const Center(child: CircularProgressIndicator(),),),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t Have An Account ?',),
                          defaultTextButton(function: ()
                          {
                            navigateAndFinish(context, ShopRegisterScreen(),);
                          }, text: 'register now')
                        ],),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );  },

      ),
    );
  }
}
