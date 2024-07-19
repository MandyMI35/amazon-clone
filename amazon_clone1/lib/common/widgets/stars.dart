import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Stars extends StatelessWidget {
  final double rating;
  const Stars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      direction: Axis.horizontal,
      itemCount: 5, //specifies how many stars to see
      rating: rating,//how many stars to be filled
      itemSize: 15,
      itemBuilder: (context,_)=> const Icon(
        Icons.star,
        color: GlobalVariables.secondaryColor,
      ),
    );
  }
}