import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone1/providers/user_provider.dart';
import 'package:amazon_clone1/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:amazon_clone1/router.dart';

void main() {
  runApp(MultiProvider(providers:[
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], 
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black
          ),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => onGenerateRoute(settings), // run everytime we use pushnamed route
      home: const AuthScreen(),
    );
  }
  generateRoute(RouteSettings settings) {}
}
