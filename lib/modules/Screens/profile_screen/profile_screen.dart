import 'package:code_app/layout/layout_cubit/layout_cubit.dart';
import 'package:code_app/modules/Screens/update_user_data_screen.dart';
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/layout_cubit/layout_states.dart';
import '../change_password_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state) {},
      builder: (context,state){
        final cubit = BlocProvider.of<LayoutCubit>(context);
        if( cubit.userModel == null ) cubit.getUserData();
        return Scaffold(
          body: cubit.userModel != null ?
              Container(
                padding: EdgeInsets.symmetric(vertical: 12,horizontal: 16),
                width: double.infinity,
                child: Column(
                  children:
                  [
                    CircleAvatar(
                      backgroundImage: NetworkImage(cubit.userModel!.image!),
                      radius: 45,
                    ),
                    const SizedBox(height: 15,),
                    Text(cubit.userModel!.name!),
                    const SizedBox(height: 10,),
                    Text(cubit.userModel!.email!),
                    const SizedBox(height: 15,),
                    MaterialButton(
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChangePasswordScreen()));
                      },
                      color: mainColor,
                      textColor: Colors.white,
                      child: const Text("Change Password"),
                    ),
                    const SizedBox(height: 15,),
                    MaterialButton(
                      onPressed: ()
                      {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateUserDataScreen()));
                      },
                      color: mainColor,
                      textColor: Colors.white,
                      child: const Text("Update Data"),
                    )
                  ],
                ),
              ) : const Center(
            child: CircularProgressIndicator(),
          )
        );
      },
    );
  }
}
