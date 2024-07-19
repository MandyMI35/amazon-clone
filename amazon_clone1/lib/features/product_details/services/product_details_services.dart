import 'dart:convert';
import 'package:amazon_clone1/constants/error_handling.dart';
import 'package:amazon_clone1/constants/utils.dart';
import 'package:amazon_clone1/models/product.dart';
import 'package:amazon_clone1/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../constants/global_variables.dart';

class ProductDetailsServices{
  void rateProduct({
    required BuildContext context,
    required Product product,
    required double rating,
    }) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
     List<Product> productList = [];
     try{
      http.Response res = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: { //uri in product.js
          'Content-Type': 'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
          'x-auth-token' : userProvider.user.token,
        },
        body: jsonEncode({
          'id':product.id,
          'rating':rating,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context, 
        onSuccess: (){
          
        },
      );
     } catch(e){
      showSnackBar(context, e.toString());
    }
  }
}