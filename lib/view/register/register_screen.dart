
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view/login/shop_login_screen.dart';
import 'package:shop_app/shared/cubit/register_cubit/states.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import '../../layout/shop_app/home_layout.dart';
import '../../shared/component/component.dart';
import '../../shared/component/constants.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/cubit/login_cubit/cubit.dart';
import '../../shared/cubit/register_cubit/cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  //const ShopRegisterScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();

  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(context)=> ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener:(context,state){
          if(state is ShopRegisterSuccessState)
          {
            if(state.modelRegister.status)//
                {
              print(state.modelRegister.status);
              print(state.modelRegister.data!.token);
              token=state.modelRegister.data!.token;//
              CacheHelper.saveData(key: 'token',
                value: state.modelRegister.data!.token,
              ).then((value){
                navigateAndFinish(context,
                  ShopLayout(),
                );
              });
              showToast(text: state.modelRegister.message!, state: ToastStates.success);
            }else{

              showToast(text: state.modelRegister.message!, state: ToastStates.error);
            }
          }

          // if(state is ShopRegisterSuccessState)//i added it
          //     {
          //   showToast(text: state.modelRegister.message!,
          //       state:state.modelRegister.status?ToastStates.success:ToastStates.error);
          //   if (state.modelRegister.status) {
          //     navigateAndFinish(context, ShopLoginScreen());
          //
          //   }
          // }
          //when i write in last error is bigger
          // when i use in listener the warning message is occur in compiler the message is in the two coming lines
          //this to line error will occur if we use this but i will use it temporary بس ده مش صح لانى مش امان
          // D/View    ( 5727): [Warning] assignParent to null: this = android.widget.FrameLayout{df8998a V.E...... ......ID 0,0-571,125}
          // I/InputTransport( 5727): Destroy ARC handle: 0xb400007cac1248c0
        },
        builder:(context,state){
          return  Scaffold(
          appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'register',
                        style: Theme.of(context).textTheme.headline4!.copyWith(fontWeight: FontWeight.bold,color: Colors.black),

                      ),
                      Text(
                        'register now to browse our hot offers',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 30,),
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
                            ShopRegisterCubit.get(context).userRegister(
                                email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text,
                            );
                          }
                        },
                        isPassword: ShopRegisterCubit.get(context).isPassword,//
                        suffix:ShopRegisterCubit.get(context).suffix ,
                        suffixOnPressed: IconButton(icon: Icon(ShopRegisterCubit.get(context).suffix),
                          onPressed: ()
                          {
                            ShopRegisterCubit.get(context).changePasswordVisibility();

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
                      defaultTextFormField(

                          controller: nameController,
                          type: TextInputType.name,//write text
                          label: 'Name',
                          prefix: Icons.person,
                          validate: (val)
                          {
                            if(val.isEmpty)
                            {
                              return 'please enter your name';
                            }return null;
                          }),
                      const SizedBox(height: 15.0,),
                      defaultTextFormField(

                          controller: phoneController,
                          type: TextInputType.phone,
                          label: 'Phone',
                          prefix: Icons.phone,
                          validate: (val)
                          {
                            if(val.isEmpty)
                            {
                              return 'please enter phone';
                            }return null;
                          }),
                      SizedBox(height: 15.0,),
                      ConditionalBuilder(
                        condition:state is ! ShopRegisterLoadingState,
                        builder:(context)=> defaultButton(function: (){
                          if(formKey.currentState!.validate())
                          {
                            ShopRegisterCubit.get(context).userRegister(email: emailController.text,
                                password: passwordController.text,
                                name: nameController.text,
                                phone: phoneController.text);





                          }

                              },
                            text: 'register'),
                        fallback:(context)=>Center(child: CircularProgressIndicator()),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        );} ,

      ),
    );
  }
}
