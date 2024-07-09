import 'package:amazon_clone1/common/widgets/bottom_bar.dart';
import 'package:amazon_clone1/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone1/features/home/screens/home_screen.dart';
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
    case BottomBar.routeName:
      return MaterialPageRoute(
       settings: routeSettings,
       builder: (_) => const BottomBar(),
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