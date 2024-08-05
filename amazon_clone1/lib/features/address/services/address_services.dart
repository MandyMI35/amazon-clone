import 'dart:convert';
import 'package:amazon_clone1/constants/error_handling.dart';
import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/constants/utils.dart';
import 'package:amazon_clone1/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';

class AddressServices {
  void saveUserAddress ({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{
  //When the Dart code sends a POST request to the /admin/add-product endpoint, 
  //the admin.js code receives the request and executes the route handler.
      http.Response res = await http.post(Uri.parse(
        '$uri.admin/save-user-address'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
          'x-auth-token' : userProvider.user.token,
        },
        body: jsonEncode({
          'address':address,
        }),
      );

      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          User user =  userProvider.user.copyWith(
            address: jsonDecode(res.body)['address']
          );

          userProvider.setUserFromModel(user);
        }
      );
    } catch(e){
      showSnackBar(context, e.toString());
    }
 }

 void placeOrder ({
  required BuildContext context, 
  required String address, 
  required double totalSum 
}) async{
     final userProvider = Provider.of<UserProvider>(context, listen: false);
     try{                                            //uri in user.js
      http.Response res = await http.post(Uri.parse('$uri/api/order'),headers: {  //Uri.parse to create a Uri object from URL string.
          'Content-Type': 'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
          'x-auth-token' : userProvider.user.token,
        },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address':address,
          'totalPrice':totalSum,
        })
      );

      httpErrorHandle(
        response: res,
        context: context, 
        onSuccess: (){
          showSnackBar(context, 'Your order has been placed!');
          User user = userProvider.user.copyWith(
            cart: [],
          );
          userProvider.setUserFromModel(user);
        },
      );
     } catch(e){
      showSnackBar(context, e.toString());
    }
  }
}