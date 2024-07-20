import 'dart:convert';
import 'dart:io';
import 'package:amazon_clone1/models/rating.dart';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  final String? id;
  final List<Rating>? rating;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.category,
    required this.images,
    this.id,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'price': price,
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        quantity: map['quantity']?.toDouble() ?? 0.0,
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        id: map[
            '_id'], //_id is the one passed by mongo, we havent done anything
        rating: map['ratings'] != null   //ratings a/c to model product
            ? List<Rating>.from(
                map['ratings']?.map(
                  (x) => Rating.fromMap(x),  //Rating.fromMap calls rating.dart
                ),
              )
            : null);
  }

  String toJson() =>
      json.encode(toMap()); // json.encode : dart object => json string

  factory Product.fromJson(String source) => Product.fromMap(json.decode(
      source)); //json string is decoded and converted to 'product' object
  // json.decode :  json string=> dart object
}
