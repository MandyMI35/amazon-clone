import 'dart:io';
import 'package:amazon_clone1/constants/error_handling.dart';
import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/constants/utils.dart';
import 'package:amazon_clone1/models/product.dart';
import 'package:amazon_clone1/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProduct ({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{
      final cloudinary = CloudinaryPublic('dr8rkkreo','vubhb9n8');
      List<String> imageUrls = [];

      for(int i=0;i<images.length;i++){
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

      http.Response res = await http.post(Uri.parse(
        '$uri.admin/add-product'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8', //MIDDLEWARE express.json() line;
          'x-auth-token' : userProvider.user.token,
        },
        body: product.toJson(),
      );

      httpErrorHandle(
        response: res, 
        context: context, 
        onSuccess: (){
          showSnackBar(context, 'Product Added Successfully');
          Navigator.pop(context);
        }
      );
    } catch(e){
      showSnackBar(context, e.toString());
    }
  }
}