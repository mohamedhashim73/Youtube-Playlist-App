import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:code_app/models/user_model.dart';
import 'package:code_app/modules/Screens/categories_screen/categories_screen.dart';
import 'package:code_app/modules/Screens/favorites_screen/favorites.dart';
import 'package:code_app/modules/Screens/home_screen/home_screen.dart';
import 'package:code_app/modules/Screens/cart_screen/cart_screen.dart';
import 'package:code_app/modules/Screens/profile_screen/profile_screen.dart';
import 'package:code_app/shared/constnts/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http ;
import 'package:code_app/layout/layout_cubit/layout_states.dart';
import 'package:http/http.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() : super(LayoutInitialState());

  int bottomNavIndex = 0 ;
  void changeBottomNavIndex({required int currentIndex}){
    bottomNavIndex = currentIndex ;
    emit(ChangeBottomNavigationIndexState());
  }

  List<Widget> layoutScreens = [HomeScreen(),CategoriesScreen(),FavoritesScreen(),CartScreen(),ProfileScreen()];

  UserModel? userModel;
  void getUserData() async {
    emit(GetUserDataLoadingState());
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/profile"),
      headers:
      {
        'Authorization' : token!,
      }
    );
    var responseData = jsonDecode(response.body);
    if( responseData['status'] == true )
      {
        userModel = UserModel.fromJson(responseData['data']);
        debugPrint("User Data is : ${responseData['data']}");
        emit(GetUserDataSuccessState());
      }
    else
      {
        emit(FailedToGetUserDataState(responseData['message']));
      }
  }
}