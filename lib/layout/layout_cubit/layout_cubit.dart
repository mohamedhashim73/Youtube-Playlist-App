import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:code_app/models/user_model.dart';
import 'package:code_app/models/category_model.dart';
import 'package:code_app/modules/Screens/cart_screen/cart_screen.dart';
import 'package:code_app/modules/Screens/categories_screen/categories_screen.dart';
import 'package:code_app/modules/Screens/favorites_screen/favorites.dart';
import 'package:code_app/modules/Screens/home_screen/home_screen.dart';
import 'package:code_app/modules/Screens/profile_screen/profile_screen.dart';
import 'package:code_app/shared/network/local_network.dart';
import 'package:http/http.dart' as http ;
import 'package:code_app/layout/layout_cubit/layout_states.dart';
import 'package:http/http.dart';
import '../../models/banner_model.dart';
import '../../models/product_model.dart';
import '../../shared/constants/constants.dart';
import 'package:flutter/material.dart';

class LayoutCubit extends Cubit<LayoutStates>{
  LayoutCubit() : super(LayoutInitialState());

  int bottomNavIndex = 0 ;
  List<Widget> layoutScreens = [HomeScreen() , CategoriesScreen(), FavoritesScreen(), CartScreen(), ProfileScreen()];
  void changeBottomNavIndex({required int index})
  {
    bottomNavIndex = index;
    // Emit state
    emit(ChangeBottomNavIndexState());
  }

  UserModel? userModel;
  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/profile"),
      headers:
      {
        'Authorization' : userToken!,
        "lang" : "en"
      }
    );
    var responseData = jsonDecode(response.body);
    if( responseData['status'] == true )
      {
        userModel = UserModel.fromJson(data: responseData['data']);
        // debugPrint("response is : $responseData");
        emit(GetUserDataSuccessState());
      }
    else
      {
        // print("response is : $responseData");
        emit(FailedToGetUserDataState(error: responseData['message']));
      }
  }

  List<BannerModel> banners = [];
  void getBannersData() async {
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/banners")
    );
    final responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
      {
        for( var item in responseBody['data'] )
          {
            banners.add(BannerModel.fromJson(data: item));
          }
        emit(GetBannersSuccessState());
      }
    else
      {
        emit(FailedToGetBannersState());
      }
  }

  List<CategoryModel> categories = [];
  void getCategoriesData() async {
    Response response = await http.get(
        Uri.parse("https://student.valuxapps.com/api/categories"),
        headers:
        {
          'lang' : "en"
        }
    );
    final responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
      for( var item in responseBody['data']['data'] )
      {
        categories.add(CategoryModel.fromJson(data: item));
      }
      emit(GetCategoriesSuccessState());
    }
    else
    {
      emit(FailedToGetCategoriesState());
    }
  }

  List<ProductModel> products = [];
  void getProducts() async {
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/home"),
      headers:
      {
        'Authorization' : userToken!,
        'lang' : "en"
      }
    );
    var responseBody = jsonDecode(response.body);
    /// print("Products Data is : $responseBody");
    // loop list
    if( responseBody['status'] == true )
      {
        for( var item in responseBody['data']['products'] )
        {
          products.add(ProductModel.fromJson(data: item));
        }
        emit(GetProductsSuccessState());
      }
    else
      {
        emit(FailedToGetProductsState());
      }
  }

  // filtered products
  List<ProductModel> filteredProducts = [];
  void filterProducts({required String input})
  {
    filteredProducts = products.where((element) => element.name!.toLowerCase().startsWith(input.toLowerCase())).toList();
    emit(FilterProductsSuccessState());
  }

  List<ProductModel> favorites = [];
  // set مفيش تكرار
  Set<String> favoritesID = {};
  Future<void> getFavorites() async {
    favorites.clear();
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/favorites"),
      headers:
      {
        "lang" : "en",
        "Authorization" : userToken!
      }
    );
    // http
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
      {
        // loop list
        for( var item in responseBody['data']['data'] )
          {
            // Refactoring
            favorites.add(ProductModel.fromJson(data: item['product']));
            favoritesID.add(item['product']['id'].toString());
          }
        print("Favorites number is : ${favorites.length}");
        emit(GetFavoritesSuccessState());
      }
    else
      {
        emit(FailedToGetFavoritesState());
      }
  }

  void addOrRemoveFromFavorites({required String productID}) async {
    Response response = await http.post(
      Uri.parse("https://student.valuxapps.com/api/favorites"),
      headers:
      {
        "lang" : "en",
        "Authorization" : userToken!
      },
      body:
      {
        "product_id" : productID
      }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
    {
        if( favoritesID.contains(productID) == true )
          {
            // delete
            favoritesID.remove(productID);
          }
        else
          {
            // add
            favoritesID.add(productID);
          }
        await getFavorites();
        emit(AddOrRemoveItemFromFavoritesSuccessState());
      }
    else
      {
        emit(FailedToAddOrRemoveItemFromFavoritesState());
      }
  }

  List<ProductModel> carts = [];
  int totalPrice = 0;
  void getCarts() async {
    carts.clear();
    Response response = await http.get(
      Uri.parse("https://student.valuxapps.com/api/carts"),
      headers:
      {
        "Authorization" : userToken!,
        "lang" : "en"
      }
    );
    var responseBody = jsonDecode(response.body);
    if( responseBody['status'] == true )
      {
        // success
        for ( var item in responseBody['data']['cart_items'] )
          {
            carts.add(ProductModel.fromJson(data: item['product']));
          }
        totalPrice = responseBody['data']['total'];
        debugPrint("Carts length is : ${carts.length}");
        emit(GetCartsSuccessState());
      }
    else
      {
        // failed
        emit(FailedToGetCartsState());
      }
  }

  void changePassword({required String userCurrentPassword,required String newPassword}) async {
    emit(ChangePasswordLoadingState());
    Response response = await http.post(
      Uri.parse("https://student.valuxapps.com/api/change-password"),
      headers:
      {
        'lang' : 'en',
        'Authorization' : userToken!
      },
      body: {
        'current_password' : userCurrentPassword,
        'new_password' : newPassword,
      }
    );
    var responseDecoded = jsonDecode(response.body);
    if( response.statusCode == 200 )
      {
        if( responseDecoded['status'] == true )
          {
            await CacheNetwork.insertToCache(key: 'password', value: newPassword);
            currentPassword = await CacheNetwork.getCacheData(key: "password");
            emit(ChangePasswordSuccessState());
          }
        else
          {
            emit(ChangePasswordWithFailureState(responseDecoded['message']));
          }
      }
    else
      {
        emit(ChangePasswordWithFailureState("something went wrong, try again later"));
      }
  }

  void updateUserData({required String name,required String phone,required String email}) async {
    emit(UpdateUserDataLoadingState());
    try
    {
      Response response = await http.put(Uri.parse("https://student.valuxapps.com/api/update-profile"),headers: {
        'lang' : 'en',
        'Authorization' : userToken!
      },body: {
        'name' : name,
        'email' : email,
        'phone' : phone
      });
      var responseBody = jsonDecode(response.body);
      if( responseBody['status'] == true )
      {
        await getUserData();
        emit(UpdateUserDataSuccessState());
      }
      else
      {
        emit(UpdateUserDataWithFailureState(responseBody['message']));
      }
    }
    catch(e){
      emit(UpdateUserDataWithFailureState(e.toString()));
    }
  }

}
