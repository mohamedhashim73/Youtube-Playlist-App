import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:code_app/shared/network/local_network.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates>{
  AuthCubit() : super(AuthInitialState());

  // Todo: API URL => https://student.valuxapps.com/api/
  // Todo: Register endpoint => register
  void register({required String email,required String name,
    required String phone,required String password}) async {
    emit(RegisterLoadingState());
    try{
      Response response = await http.post(
        // request Url = base url + method url ( endpoint ) = https://student.valuxapps.com + /api/register
          Uri.parse('https://student.valuxapps.com/api/register'),
          body: {
            'name' : name,
            'email' : email,
            'password' : password,
            'phone' : phone,
            'image' : "jdfjfj"     // الصوره مش شغاله بس لازم ابعت قيمه ك value
          },
      );
      if( response.statusCode == 200 )
        {
          var data = jsonDecode(response.body);
          if( data['status'] == true )
            {
              debugPrint("Response is : $data");
              emit(RegisterSuccessState());
            }
          else
            {
              debugPrint("Response is : $data");
              emit(FailedToRegisterState(message: data['message']));
            }
        }
    }
    catch(e){
      debugPrint("Failed to Register , reason : $e");
      emit(FailedToRegisterState(message: e.toString()));
    }
  }

  // Account : mo.ha@gmail.com , password : 123456
  void login({required String email,required String password}) async {
    emit(LoginLoadingState());
    try{
      Response response = await http.post(
        // request => url = base url + method url
        Uri.parse('https://student.valuxapps.com/api/login'),
        body: {
          'email' : email,
          'password' : password
        },
      );
      if( response.statusCode == 200 )
        {
          var responseData = jsonDecode(response.body);
          if( responseData['status'] == true )
            {
              // debugPrint("User login success and his Data is : ${responseData['data']['token']}");
              await CacheNetwork.insertToCache(key: "token", value: responseData['data']['token']);
              emit(LoginSuccessState());
            }
          else
            {
              debugPrint("Failed to login, reason is : ${responseData['message']}");
              emit(FailedToLoginState(message: responseData['message']));
            }
        }
    }
    catch(e){
      emit(FailedToLoginState(message: e.toString()));
    }
  }
}

/*
Response after login
{
    "status": true,
    "message": "Registration done successfully",
    "data": {
        "name": "Saleh Ahmed",
        "phone": "0125454412",
        "email": "mohamed.hashim73@gmail.com",
        "id": 52821,
        "image": "https://student.valuxapps.com/storage/uploads/users/CpFliPNQdd_1677580291.jpeg",
        "token": "EbiEk1Tt5UHmHaYbwLvcTdDRPQPYPCQccIBVhH1bwGDnfrAT78ddMB96IKMN3Nv8jpLQAk"
    }
}
 */