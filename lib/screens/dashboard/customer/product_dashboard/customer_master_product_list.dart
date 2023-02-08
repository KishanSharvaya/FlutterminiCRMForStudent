import 'package:flutter/material.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/screens/dashboard/customer/product_dashboard/cart_screen.dart';
import 'package:minicrm/screens/dashboard/customer/product_dashboard/dashboard.dart';
import 'package:minicrm/screens/dashboard/customer/product_dashboard/my_order.dart';
import 'package:minicrm/screens/dashboard/customer/product_dashboard/user_profile.dart';
import 'package:minicrm/screens/login_screen/login_screen.dart';
import 'package:minicrm/utils/general_utils.dart';

class CustomerDashBoard extends StatefulWidget {
  static const routeName = '/CustomerDashBoard';

  @override
  State<CustomerDashBoard> createState() => _CustomerDashBoardState();
}

class _CustomerDashBoardState extends State<CustomerDashBoard> {
  int pageIndex = 1;

  List<Widget> pages = [
    CartScreen(),
    DashBoard(),
    MyOrder(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "DashBoard",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
          InkWell(
              onTap: () {
                navigateTo(context, LoginPage.routeName, clearAllStack: true);
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.home,
                  color: colorPrimary,
                ),
              )),
        ],
      ),
      body: pages[pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 0;
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                          pageIndex == 0
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          color: colorWhite,
                          size: 24),
                      Text(
                        "Cart",
                        style: TextStyle(fontSize: 10, color: colorWhite),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 1;
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                      Icon(pageIndex == 1 ? Icons.home : Icons.home_outlined,
                          size: 24, color: colorWhite),
                      Text(
                        "Home",
                        style: TextStyle(fontSize: 10, color: colorWhite),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 2;
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                          pageIndex == 2
                              ? Icons.featured_play_list
                              : Icons.featured_play_list_outlined,
                          size: 24,
                          color: colorWhite),
                      Text(
                        "Order",
                        style: TextStyle(fontSize: 10, color: colorWhite),
                      )
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    pageIndex = 3;
                  });
                },
                child: Container(
                  child: Column(
                    children: [
                      Icon(
                          pageIndex == 3
                              ? Icons.person
                              : Icons.person,
                          size: 24,
                          color: colorWhite),
                      Text(
                        "Profile",
                        style: TextStyle(fontSize: 10, color: colorWhite),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
