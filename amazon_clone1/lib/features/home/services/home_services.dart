import 'dart:convert';

import 'package:amazon_clone1/constants/error_handling.dart';
import 'package:amazon_clone1/constants/utils.dart';
import 'package:amazon_clone1/models/product.dart';
import 'package:amazon_clone1/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../constants/global_variables.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?category=$category'), headers: {
        //yri in product.js
        'Content-Type':
            'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      if (context.findAncestorWidgetOfExactType<Scaffold>() != null) {
        showSnackBar(context, e.toString());
      } else {
        print('Error: $e');
      }
    }
    return productList;
  }

  Future<Product> fetchDealOfDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: '',
      description: '',
      price: 0,
      quantity: 0,
      category: '',
      images: [],
    );
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/api/deal-of-day'), headers: {
        //uri in product.js
        'Content-Type':
            'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          product = Product.fromJson(res.body);
        },
      );
    } catch (e) {
      if (context.findAncestorWidgetOfExactType<Scaffold>() != null) {
        showSnackBar(context, e.toString());
      } else {
        print('Error: $e');
      }
    }
    return product;
  }
}
