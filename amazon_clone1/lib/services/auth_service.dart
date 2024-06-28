import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; //make api request to the localhost url in thunderclient

class AuthService{

  //sign up user
  void signUpUser({
    required String email,
    required String password,
    required String name,
  }) async {
    try{
      User user = User(
        id: '', 
        name: name, 
        email: email, 
        password: password, 
        address: '', 
        type: '', 
        token: '');

        http.Response res = await http.post(
          Uri.parse('$uri/api/signup'),
          body:user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',  //MIDDLEWARE express.json() line;
          }
        );
    } catch(e){
      
    }
  }
}