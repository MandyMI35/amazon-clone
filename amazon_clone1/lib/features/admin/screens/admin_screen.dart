import 'package:amazon_clone1/constants/global_variables.dart';
import 'package:amazon_clone1/features/account/screens/account_screen.dart';
import 'package:amazon_clone1/features/admin/screens/orders_screen.dart';
import 'package:amazon_clone1/features/admin/screens/posts_screen.dart';
import 'package:amazon_clone1/features/home/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page =0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages =[
    const PostsScreen(),
    const Center(child: Text('Analytics page'),),
    const OrdersScreen()
  ];

  void updatePage(int page) {
    setState(() {
      _page=page;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar( //we need a gradient but appbar doesnt have that property so we add container to do that
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              const Text(
                'Admin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
      body: IndexedStack( //It is a widget, allows you to display a stack of widgets, where only one widget is visible at a time, based on an index.
        index: _page,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.unselectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          //POSTS
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: _page ==0 
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                ),
              ),
            ),
            child: const Icon(
              Icons.home_outlined,
            ),
          ),
          label: '',
          ),
          //ANALYTICS
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: _page ==1 
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                ),
              ),
            ),
            child: const Icon(
              Icons.analytics_outlined,
            ),
          ),
          label: '',
          ),
          //ORDERS
          BottomNavigationBarItem(icon: Container(
            width: bottomBarWidth,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: _page ==2 
                    ? GlobalVariables.selectedNavBarColor
                    : GlobalVariables.backgroundColor,
                  width: bottomBarBorderWidth,
                ),
              ),
            ),
            child: const Icon(
              Icons.all_inbox_outlined,
            ),
          ),
          label: '',
          ),
        ],
      ),
    );
  }
}