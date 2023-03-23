import 'package:code_app/layout/layout_cubit/layout_cubit.dart';
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'layout_cubit/layout_states.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: thirdColor,
            elevation: 0,
            title: SvgPicture.asset("images/logo.svg",height: 40,width: 40,color: mainColor,),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.bottomNavIndex,
            selectedItemColor: mainColor,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
            onTap: (index)
            {
              cubit.changeBottomNavIndex(index: index);
            },
            items:
            const
            [
              BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.category),label: "Categories"),
              BottomNavigationBarItem(icon: Icon(Icons.favorite),label: "Favorites"),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: "Cart"),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: "Profile"),
            ],
          ),
          body: cubit.layoutScreens[cubit.bottomNavIndex],
        );
      },
    );
  }
}
