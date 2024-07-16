import 'dart:convert';
import 'dart:io';

class Product {
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String category;
  final List<String> images;
  final String? id;

  Product(
      {required this.name,
      required this.description,
      required this.price,
      required this.quantity,
      required this.category,
      required this.images,
      required this.id,
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
      id: map['_id'], //_id is the one passed by mongo, we havent done anything
    );
  }

  String toJson() => json.encode(toMap());   // json.encode : dart object => json string

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source)); //json string is decoded and converted to 'product' object
                                       // json.decode :  json string=> dart object
}
