import 'package:flutter/material.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/screens/dashboard/customer/product_dashboard/cart_screen.dart';
import 'package:minicrm/screens/dashboard/customer/product_dashboard/dashboard.dart';
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.person_2_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            /* IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                Icons.view_list_rounded,
                color: Colors.white,
                size: 35,
              )
                  : const Icon(
                Icons.view_list,
                color: Colors.white,
                size: 35,
              ),
            ),*/
          ],
        ),
      ),
    );

  }
}
