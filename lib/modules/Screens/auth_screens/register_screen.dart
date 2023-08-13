import 'package:code_app/modules/Screens/auth_screens/login_screen.dart';
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Widgets/alert_dialog.dart';
import '../home_screen/home_screen.dart';
import 'auth_cubit/auth_cubit.dart';
import 'auth_cubit/auth_states.dart';

class RegisterScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context,state){
        if( state is RegisterLoadingState )
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
                    SizedBox(width: 12.5,),
                    const Text("wait",style: TextStyle(fontWeight: FontWeight.w500),),
                  ],
                ),
              )
          );
        }
        else if( state is FailedToRegisterState )
        {
          showAlertDialog(
              context: context,
              backgroundColor: Colors.red,
              content: Text(state.message,textDirection: TextDirection.rtl,)
          );
        }
        else if ( state is RegisterSuccessState )
        {
          Navigator.pop(context);   // عشان يخرج من alertDialog
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
        }
      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(backgroundColor: Colors.transparent,elevation: 0,leading: const Text(""),),
          body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text("Sign Up",style: TextStyle(fontSize: 22.5,fontWeight: FontWeight.bold),),
                        SizedBox(height: 30,),
                        textFormItem(hintTitle: "User Name", controller: nameController),
                        SizedBox(height: 20,),
                        textFormItem(hintTitle: "Email", controller: emailController),
                        SizedBox(height: 20,),
                        textFormItem(hintTitle: "Phone", controller: phoneController),
                        SizedBox(height: 20,),
                        textFormItem(hintTitle: "Password", controller: passwordController),
                        SizedBox(height: 20,),
                        MaterialButton(
                          minWidth: double.infinity,
                          elevation: 0,
                          height: 40,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                          ),
                          color: mainColor,
                          onPressed: ()
                          {
                            if( formKey.currentState!.validate() == true )
                            {
                              BlocProvider.of<AuthCubit>(context).register(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text
                              );
                            }
                          },
                          child: FittedBox(fit:BoxFit.scaleDown,child: Text(state is RegisterLoadingState ? "Loading..." : "Register",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16.5,color: Colors.white),)),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          [
                            const Text('Already have an account? ',style: TextStyle(color: Colors.black)),
                            SizedBox(width: 4,),
                            InkWell(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              },
                              child: const Text('login in',style: TextStyle(color: mainColor,fontWeight: FontWeight.bold)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                )
            ),
          ),
        );
      },
    );
  }

  // TextFormField Item as I use it more than one time
  Widget textFormItem({required String hintTitle,required TextEditingController controller}){
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintTitle,
          border: const OutlineInputBorder()
      ),
      validator: (input)
      {
        if( controller.text.isNotEmpty )
        {
          return null;
        }
        else
        {
          return "$hintTitle must not be empty!";
        }
      },
    );
  }
}
