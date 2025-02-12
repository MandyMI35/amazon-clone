import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone1/constants/error_handling.dart';
import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/constants/utils.dart';
import 'package:amazon_clone1/features/admin/models/sales.dart';
import 'package:amazon_clone1/models/order.dart';
import 'package:amazon_clone1/models/product.dart';
import 'package:amazon_clone1/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dr8rkkreo', 'vubhb9n8');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i].path, folder: name),
          //CloudinaryFile.fromBytes(bytes, folder: name),
        );
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
        id: '',
      );
      //When the Dart code sends a POST request to the /admin/add-product endpoint,
      //the admin.js code receives the request and executes the route handler.
      http.Response res = await http.post(
        Uri.parse('$uri.admin/add-product'),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Product Added Successfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-products'), headers: {
        //Uri.parse to create a Uri object from URL string.
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
            ); //fromMap(dart obj)
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess //to use set state fnxn
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri.admin/delete-product'),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> fetchAllOrders(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Order> orderList = [];
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        //Uri.parse to create a Uri object from URL string.
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
            ); //fromMap(dart obj)
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderList;
  }

  void changeOrderStatus(
      {required BuildContext context,
      required int status,
      required Order order,
      required VoidCallback onSuccess //to use set state fnxn
      }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri.admin/change-order-status'),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': order.id,
          'status': status,
        }),
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            onSuccess();
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Map<String, dynamic>> getEarnings(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Sales> sales = [];
    int totalEarning = 0;
    try {
      http.Response res =
          await http.get(Uri.parse('$uri/admin/get-orders'), headers: {
        //Uri.parse to create a Uri object from URL string.
        'Content-Type':
            'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          var response = jsonDecode(res.body);
          totalEarning = response['totalEarnings'];
          sales = [
            Sales(label: 'Mobiles', earning: response['mobileEarnings']),
            Sales(label: 'Essentials', earning: response['essentialEarnings']),
            Sales(label: 'Books', earning: response['booksEarnings']),
            Sales(label: 'Appliances', earning: response['applianceEarnings']),
            Sales(label: 'Fashion', earning: response['fashionEarnings']),
          ];
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return {
      'sales': sales,
      'totalEarnings':totalEarning,
    };
  }
}
