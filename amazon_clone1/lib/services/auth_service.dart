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

//http.post(...): This function sends an HTTP POST request to the specified URL.
        http.Response res = await http.post(    //The result of the http.post request is stored in the variable res. It is of type http.Response, which contains the response data from the server.
          Uri.parse('$uri/api/signup'),     //Uri.parse(...) function converts a string into a Uri object. '$uri/api/signup': This is the URL to which the 
          //POST request is sent. $uri is a variable and /api/signup is the endpoint for user registration.
          body:user.toJson(),                   //Converts the User object to a JSON
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',  //MIDDLEWARE express.json() line;
          }
        );
    } catch(e){
      
    }
  }
}