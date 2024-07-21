import 'dart:convert';

import 'package:amazon_clone1/common/widgets/bottom_bar.dart';
import 'package:amazon_clone1/constants/error_handling.dart';
import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/constants/utils.dart';
import 'package:amazon_clone1/features/home/screens/home_screen.dart';
import 'package:amazon_clone1/models/user.dart';
import 'package:amazon_clone1/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart'; //make api request to the localhost url in thunderclient

class AuthService {
  //sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '',
          cart: [],
        );

//http.post(...): This function sends an HTTP POST request to the specified URL.
      http.Response res = await http.post(
          //The result of the http.post request is stored in the variable res. It is of type http.Response, which contains the response data from the server.
          Uri.parse(
              '$uri/api/signup'), //Uri.parse(...) function converts a string into a Uri object. '$uri/api/signup': This is the URL to which the
          //POST request is sent. $uri is a variable and /api/signup is the endpoint for user registration.
          body: user.toJson(), //Converts the User object to a JSON
          headers: <String, String>{
            //put this line everytime we make request to api . due to app.use(express.json()); in index.js
            'Content-Type':
                'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
          });

          httpErrorHandle(   //calls the fnxn from constants/error_handling.dart
            response: res, 
            context: context, 
            onSuccess: (){
              showSnackBar(
                context, 
                'Account created! Login with same credentials'
              );
            }
          );
    } catch (e) {
      showSnackBar(
                context, 
                e.toString()
              );
    }
  }
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
          Uri.parse('$uri/api/signin'), 
          body: jsonEncode({
            'email': email,
            'password':password,
            }
          ), 
          headers: <String, String>{
            
            'Content-Type':
                'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
          });
          print(res.body);
          httpErrorHandle(  ///////////////////////////////
            response: res, 
            context: context, 
            onSuccess: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();  // Gets an instance of SharedPreferences, which is used to store data locally on the device
              Provider.of<UserProvider>(context, listen:false).setUser(res.body);
              await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);  //stores the access token retrieved from the API response in SharedPreferences, prefs.setString stores a string value under the key "x-auth-token"
              Navigator.pushNamedAndRemoveUntil(context, BottomBar.routeName, (route)=>false);  //false means that all previous routes will be removed from the navigator.
            }
          );
    } catch (e) {
      showSnackBar(
                context, 
                e.toString()
              );
    }
  }
  //get user data
  //we want user data,through an self created api for which we need token
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if(token == null){   //user has used the app first time and now the token is ' not null
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(    //calls the tokenIsValid api in auth.js to check if the token is genuine
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
        }
      );

      var response = jsonDecode(tokenRes.body);
      
      if (response == true) {
        //call api to get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userRes.body);
      }
    }
    catch(e){
      showSnackBar(context, e.toString());
    }
  }

  // token will be passed thorugh header not body
}
