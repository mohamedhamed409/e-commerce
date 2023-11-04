import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/view/search/cubit/states.dart';
import 'package:shop_app/shared/cubit/search_cubit/cubit.dart';
import 'package:shop_app/shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();
  var formKey=GlobalKey<FormState>();

   SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
          appBar:AppBar(),//if you do not write this line we can not find the arrow of navigation we made in component
          body: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
defaultTextFormField(
    controller: searchController,
    type: TextInputType.text,
    label: 'Search',
    prefix: Icons.search,
    validate: (value)
    {
      if(value.isEmpty)
      {
        return 'enter text to search';
      }
      return null;
    },
  onSubmit: (text)
  {
SearchCubit.get(context).search(text);

  }

),
                SizedBox(height: 10.0,),
                if(state is SearchLoadingState)
                LinearProgressIndicator(),
                SizedBox(height: 10.0,),
                if(state is SearchSuccessState)
                Expanded(
                  child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context,index)=>buildListItem(
                          SearchCubit.get(context).searchModel!.data!.data2[index],context,isOldPrice: false),
                      separatorBuilder: (context,index)=>Container(width: double.infinity,height: 1,),
                      itemCount: SearchCubit.get(context).searchModel!.data!.data2.length),
                ),
              ],),
            ),
          ),
        );
          },

      ),
    );
  }
}
