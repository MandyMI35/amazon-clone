import 'dart:io';
import 'package:amazon_clone1/constants/utils.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';

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
    try{
      final cloudinary = CloudinaryPublic('dr8rkkreo', CLOUDINARY_URL=cloudinary://271411331886678:Jcg92CHT8Hm4_n-Kbv8zQ5IGLv0@dr8rkkreo)
    } catch(e){
      showSnackBar(context, e.toString());
    }
  }
}