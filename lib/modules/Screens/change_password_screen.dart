import 'package:code_app/layout/layout_cubit/layout_cubit.dart';
import 'package:code_app/layout/layout_cubit/layout_states.dart';
import 'package:code_app/shared/constants/constants.dart';
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangePasswordScreen extends StatelessWidget {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        backgroundColor: thirdColor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children:
          [
            TextField(
              controller: currentPasswordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Current Password"
              ),
            ),
            SizedBox(height: 16,),
            TextField(
              controller: newPasswordController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "New Password"
              ),
            ),
            SizedBox(height: 24,),
            BlocConsumer<LayoutCubit,LayoutStates>(
                listener: (context,state){
                  if( state is ChangePasswordSuccessState )
                    {
                      showSnackBarItem(context, "Password Updated Successfully", true);
                      Navigator.pop(context);
                    }
                  if( state is ChangePasswordWithFailureState )
                    {
                      showSnackBarItem(context, state.error, false);
                    }
                },
                builder: (context,state)
                {
                  return MaterialButton(
                    onPressed: ()
                    {
                      debugPrint("From TextField : ${currentPasswordController.text} , current : $currentPassword");
                      if( currentPasswordController.text == currentPassword )
                      {
                        if( newPasswordController.text.length >= 6 )
                        {
                          cubit.changePassword(userCurrentPassword: currentPassword!, newPassword: newPasswordController.text.trim());
                        }
                        else
                        {
                          showSnackBarItem(context,"Password must be at least 6 characters",false);
                        }
                      }
                      else
                      {
                        showSnackBarItem(context,"please, verify current password, try again later",false);
                      }
                    },
                    color: mainColor,
                    height: 45,
                    minWidth: double.infinity,
                    textColor: Colors.white,
                    child: Text(state is ChangePasswordLoadingState ? "Loading..." : "Update"),
                  );
                }
            )
          ],
        ),
      ),
    );
  }

  void showSnackBarItem(BuildContext context,String message,bool forSuccessOrFailure){
    ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(message),backgroundColor: forSuccessOrFailure ? Colors.green : Colors.red,));
  }
}
