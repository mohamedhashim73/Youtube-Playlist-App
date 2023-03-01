import 'package:code_app/modules/Screens/auth_screens/auth_cubit/auth_cubit.dart';
import 'package:code_app/modules/Screens/auth_screens/register_screen.dart';
import 'package:code_app/modules/Screens/home_screen/home_screen.dart';
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widgets/alert_dialog.dart';
import 'auth_cubit/auth_states.dart';
class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("images/auth_background.png"),fit: BoxFit.fill)
        ),
        child: BlocConsumer<AuthCubit,AuthStates>(
          listener: (context,state)
          {
            if( state is LoginLoadingState )
            {
              showAlertDialog(
                  context: context,
                  backgroundColor: Colors.white,
                  content: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.easeIn,
                    child: Row(
                      children:
                      [
                        const CupertinoActivityIndicator(color: mainColor),
                        SizedBox(width: 12.5.w,),
                        const Text("wait",style: TextStyle(fontWeight: FontWeight.w500),),
                      ],
                    ),
                  )
              );
            }
            else if( state is FailedToLoginState )
            {
              showAlertDialog(
                  context: context,
                  backgroundColor: Colors.red,
                  content: Text(state.message,textDirection: TextDirection.rtl,)
              );
            }
            else if ( state is LoginSuccessState )
            {
              Navigator.pop(context);   // عشان يخرج من alertDialog
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
            }
          },
          builder: (context,state){
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.only(bottom: 50.h),
                    child: const Text("Login to continue process",style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 35),
                    decoration: BoxDecoration(
                        color: thirdColor,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                        [
                          Text("Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                          TextFormField(
                            controller: emailController,
                            decoration: const InputDecoration(
                              hintText: "Email",
                            ),
                            validator: (input){
                              if( emailController.text.isNotEmpty )
                              {
                                return null;
                              }
                              else
                              {
                                return "Email must not be empty";
                              }
                            },
                          ),
                          SizedBox(height: 15,),
                          TextFormField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: "Password",
                            ),
                            validator: (input){
                              if( passwordController.text.isNotEmpty )
                              {
                                return null;
                              }
                              else
                              {
                                return "Password must not be empty";
                              }
                            },
                          ),
                          SizedBox(height: 25.h,),
                          MaterialButton(
                            height: 40.h,
                            elevation: 0,
                            onPressed: ()
                            {
                              if( formKey.currentState!.validate() == true )
                                {
                                  BlocProvider.of<AuthCubit>(context).login(
                                      email: emailController.text,
                                      password: passwordController.text,
                                  );
                                }
                            },
                            minWidth: double.infinity,
                            color: mainColor,
                            textColor: Colors.white,
                            child: FittedBox(fit:BoxFit.scaleDown,child: Text(state is LoginLoadingState ? "Loading..." : "Login",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.5.sp),)),
                          ),
                          SizedBox(height: 15.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children:
                            [
                              const Text('Don\'t have an account? ',style: TextStyle(color: Colors.black)),
                              SizedBox(width: 4.w,),
                              InkWell(
                                onTap: ()
                                {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
                                },
                                child: const Text('Create one',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        )
      ),
    );
  }
}
