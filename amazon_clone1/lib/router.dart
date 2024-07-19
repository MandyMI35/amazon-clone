import 'package:amazon_clone1/common/widgets/bottom_bar.dart';
import 'package:amazon_clone1/features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone1/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone1/features/home/screens/category_deals_screen.dart';
import 'package:amazon_clone1/features/home/screens/home_screen.dart';
import 'package:amazon_clone1/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone1/features/search/screens/search_screen.dart';
import 'package:amazon_clone1/models/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings){
  switch(routeSettings.name){
    case AuthScreen.routeName:
       return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
       settings: routeSettings,
       builder: (_) => const HomeScreen(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
       settings: routeSettings,
       builder: (_) => const AddProductScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
       settings: routeSettings,
       builder: (_) => const BottomBar(),
      );
    case CategoryDealsScreen.routeName:
    var category = routeSettings.arguments as String;
      return MaterialPageRoute(
       settings: routeSettings,
       builder: (_) => CategoryDealsScreen(
        category: category,
      ),
      );
    case SearchScreen.routeName:
    var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
       settings: routeSettings,
       builder: (_) => SearchScreen(searchQuery: searchQuery,),
      );
    case ProductDetailsScreen.routeName:
    var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
       settings: routeSettings,
       builder: (_) => ProductDetailsScreen( product: product,),
      );
    default:
    return MaterialPageRoute(
      settings: routeSettings,
      builder: (_)=>const Scaffold(
        body: Center(
          child: Text('screen does not exist1'),
      ),
    ));
  }
}