import 'package:amazon_clone1/common/widgets/bottom_bar.dart';
import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/features/admin/screens/admin_screen.dart';
import 'package:amazon_clone1/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone1/providers/user_provider.dart';
import 'package:amazon_clone1/router.dart';
import 'package:amazon_clone1/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) =>
          onGenerateRoute(settings), // run everytime we use pushnamed route
      home: 
        Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'user'
              ? const BottomBar()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }

  generateRoute(RouteSettings settings) {}
}



// Provider.of<UserProvider>(context).user.token.isEmpty
//           ? const AuthScreen(),
//            Provider.of<UserProvider>(context).user.type == 'user'
//               ? const AdminScreen()
//               : const AdminScreen()
//            const AuthScreen(),


// if (Provider.of<UserProvider>(context).user.token.isNotEmpty){
//  if (Provider.of<UserProvider>(context).user.type == 'user') {return const BottomBar()}
//   else if (Provider.of<UserProvider>(context).user.type == 'admin'){return const AdminScreen()}
// else return const AuthScreen()
// }