import 'dart:convert';
import 'package:amazon_clone1/constants/error_handling.dart';
import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/constants/utils.dart';
import 'package:amazon_clone1/models/order.dart';
import 'package:amazon_clone1/models/product.dart';
import 'package:amazon_clone1/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AccountServices{
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/orders/me'), headers: {
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
            orderList.add(
              Order.fromJson(
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
    return orderList;
  }
}