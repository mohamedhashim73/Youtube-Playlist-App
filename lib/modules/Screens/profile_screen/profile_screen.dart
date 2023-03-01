import 'package:code_app/layout/layout_cubit/layout_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/layout_cubit/layout_cubit.dart';
import '../../../shared/style/colors.dart';

class ProfileScreen extends StatelessWidget{
  ProfileScreen({super.key});
  @override
  Widget build(context){
    LayoutCubit cubit = BlocProvider.of<LayoutCubit>(context);
    return Builder(
        builder: (context) {
          if( cubit.userModel == null ) cubit.getUserData();   // as if I log out will get the new info
          return Scaffold(
              appBar: AppBar(title: const Text("Profile"),elevation: 0,backgroundColor: thirdColor,foregroundColor: Colors.black,),
              body: BlocConsumer<LayoutCubit,LayoutStates>(
                  listener:(context,state){},
                  builder: (context,state){
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                      [
                        Expanded(
                            flex: 3,
                            child: cubit.userModel != null ?
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  child: const Icon(Icons.person,size: 60,color: mainColor,),
                                ),
                                const SizedBox(height: 20),
                                Text(cubit.userModel!.name.toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                const SizedBox(height: 10),
                                Text(cubit.userModel!.email.toString(),style: const TextStyle(color:Colors.grey,fontWeight: FontWeight.bold,fontSize: 16),)
                              ],
                            ) :
                            const CupertinoActivityIndicator(color: mainColor,)
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: Column(
                              children:
                              [
                                _buttonItem(iconData: Icons.person,title: "Update Data",onTap: (){}),
                                const SizedBox(height: 15,),
                                _buttonItem(iconData: Icons.shopping_cart,title: "Orders",onTap: (){}),
                                const SizedBox(height: 15,),
                                _buttonItem(iconData: Icons.favorite,title: "Favorite",onTap: (){}),
                                const SizedBox(height: 15,),
                                _buttonItem(
                                    iconData: Icons.logout,
                                    title: "Log out",
                                    onTap: ()
                                    {

                                    }
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  }
              )
          );
        }
    );
  }

  // عاملها عشان هستعمل الوديجت اكتر من مره ف عشان اقلل م الكود عملتها ك داله بترجع الوديجت ده وبأخد الحاجات اللي بتتغير بس
  Widget _buttonItem({required dynamic onTap,required String title,required IconData iconData}){
    return MaterialButton(
        height: 45,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5)
        ),
        minWidth:double.infinity,
        onPressed: onTap,
        color: fourthColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:
          [
            Icon(iconData,color: Colors.black.withOpacity(0.5),size: 22,),
            const SizedBox(width: 15,),
            Text(title,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17,color: mainColor),)
          ],
        )
    );
  }
}