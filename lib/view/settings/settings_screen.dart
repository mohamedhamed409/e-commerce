import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/styles/colors.dart';

import '../../shared/component/constants.dart';

class SettingsScreen extends StatelessWidget {
   //const SettingsScreen({Key? key}) : super(key: key);
  var formKey=GlobalKey<FormState>();
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  @override
  Widget build(BuildContext context) {


    return BlocConsumer<ShopLayoutCubit,ShopLayoutStates>(
      listener: (context,state){
       //  if(state is ShopSuccessGetProfileDataState)
       //  {
       // //   nameController.text=ShopLayoutCubit.get(context).profileModel!.data!.name.toString();
       //     // nameController.text=state.model.data!.name!;
       //
       //  }
        if(state is ShopSuccessUpdateDataState)
        {
          if(state.model.status)
          {
            showToast(text: state.model.message!, state: ToastStates.success);
          }
          else
          {
            showToast(text: state.model.message!, state: ToastStates.error);
          }
        }
      },
      builder: (context,state){
        var model =ShopLayoutCubit.get(context).profileModel;

        nameController.text=model!.data!.name!;
        emailController.text=model.data!.email!;
        phoneController.text=model.data!.phone!;

        return ConditionalBuilder(
        condition: ShopLayoutCubit.get(context).profileModel!=null,
        builder: (context)=> Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [

                    if(state is ShopLoadingUpdateDataState)
                    LinearProgressIndicator(),

                    SizedBox(height: 20.0,),
                    defaultTextFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      label: 'Name',
                      prefix: Icons.person,
                      validate: (val)
                      {
                        if(val!.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0,),
                    defaultTextFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'Email Address',
                      prefix: Icons.email,
                      validate: (val)
                      {
                        if(val!.isEmpty)
                        {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0,),
                    defaultTextFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      label: 'Phone',
                      prefix: Icons.phone,
                      validate: (val)
                      {
                        if(val!.isEmpty)
                        {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0,),
                    defaultButton(

                        function: ()
                        {
                          if(formKey.currentState!.validate())
                          {
                                ShopLayoutCubit.get(context).updateData(
                                myName: nameController.text,
                                myEmail: emailController.text,
                                myPhone: phoneController.text);
                          }

                        },
                        text: 'Update'),
                    SizedBox(height: 20.0,),

                    defaultButton(

                   //   myColor: defaultColor,
                        function: ()
                    {
                   logOut(context);
                    },
                        text: 'Log Out'),
                  ],
                ),
              ),
            ),
          ),
        ),
        fallback:(context)=>Center(child: CircularProgressIndicator()) ,

      );},
    );
  }
}
