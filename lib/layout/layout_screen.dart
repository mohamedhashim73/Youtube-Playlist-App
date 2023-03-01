import 'package:code_app/layout/layout_cubit/layout_cubit.dart';
import 'package:code_app/layout/layout_cubit/layout_states.dart';
import 'package:code_app/shared/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LayoutCubit>(context);
    return BlocConsumer<LayoutCubit,LayoutStates>(
        listener: (context,state)
        {

        },
        builder: (context,state){
          return Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: mainColor,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              unselectedLabelStyle: TextStyle(color: Colors.grey),
              currentIndex: BlocProvider.of<LayoutCubit>(context).bottomNavIndex,
              onTap: (currentIndex)
              {
                debugPrint("Current index is : $currentIndex");
                BlocProvider.of<LayoutCubit>(context).changeBottomNavIndex(currentIndex: currentIndex);
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
        }
    );
  }
}
