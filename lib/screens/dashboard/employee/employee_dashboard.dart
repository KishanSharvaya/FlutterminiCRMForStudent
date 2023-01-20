import 'package:flutter/material.dart';
import 'package:minicrm/screens/dashboard/employee/customer/customer_list.dart';
import 'package:minicrm/screens/login_screen/login_screen.dart';
import 'package:minicrm/utils/general_utils.dart';
import 'package:minicrm/utils/shared_pref_helper.dart';

class EmployeeDashBoard extends StatefulWidget {
  const EmployeeDashBoard({Key key}) : super(key: key);
  static const routeName = '/EmployeeDashBoard';

  @override
  State<EmployeeDashBoard> createState() => _EmployeeDashBoardState();
}

class _EmployeeDashBoardState extends State<EmployeeDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                SharedPrefHelper.instance
                    .putBool(SharedPrefHelper.IS_LOGGED_IN, false);
                navigateTo(context, LoginPage.routeName, clearAllStack: true);
              },
              child: Icon(
                Icons.login,
                size: 100,
              )),
          SizedBox(
            height: 10,
          ),
          InkWell(
              onTap: () {
                navigateTo(context, CustomerListScreen.routeName);
              },
              child: Icon(
                Icons.people,
                size: 100,
              )),
        ],
      )),
    );
  }
}
