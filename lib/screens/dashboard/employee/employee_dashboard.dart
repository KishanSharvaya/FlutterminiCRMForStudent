import 'package:flutter/material.dart';
import 'package:minicrm/screens/dashboard/employee/customer/customer_list.dart';
import 'package:minicrm/screens/dashboard/employee/daily_activity/activity_list.dart';
import 'package:minicrm/screens/dashboard/employee/followup/followup_list_screen.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/inquiry_list.dart';
import 'package:minicrm/screens/dashboard/employee/product_master/master_product_list.dart';
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
      appBar: AppBar(
        title: Text("DashBoard"),
        actions: [
          InkWell(
              onTap: () {
                SharedPrefHelper.instance
                    .putString(SharedPrefHelper.IS_LOGGED_IN, "");
                navigateTo(context, LoginPage.routeName, clearAllStack: true);
              },
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: Icon(
                  Icons.login,
                  size: 35,
                ),
              )),
        ],
      ),
      body: Center(
          child: Container(
        margin: EdgeInsets.all(40),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: InkWell(
                      onTap: () {
                        navigateTo(context, CustomerListScreen.routeName);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.people,
                            size: 50,
                          ),
                          Text("Customer")
                        ],
                      )),
                ),
                Flexible(
                  child: InkWell(
                      onTap: () {
                        navigateTo(context, InquiryListScreen.routeName);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.call,
                            size: 50,
                          ),
                          Text("Inquiry")
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: InkWell(
                      onTap: () {
                        navigateTo(context, FollowupListScreen.routeName);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.follow_the_signs,
                            size: 50,
                          ),
                          Text("Follow-Up")
                        ],
                      )),
                ),
                Flexible(
                  child: InkWell(
                      onTap: () {
                        navigateTo(context, DailyActivityListScreen.routeName);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.task,
                            size: 50,
                          ),
                          Text("Daily Activity")
                        ],
                      )),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: InkWell(
                      onTap: () {
                        showCommonDialogWithSingleOption(context, "Coming Soon",
                            positiveButtonTitle: "OK");
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.emoji_people,
                            size: 50,
                          ),
                          Text("Employee")
                        ],
                      )),
                ),
                Flexible(
                  child: InkWell(
                      onTap: () {
                        showCommonDialogWithSingleOption(context, "Coming Soon",
                            positiveButtonTitle: "OK");
                        navigateTo(context, GeneralProductListScreen.routeName);
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.pages_rounded,
                            size: 50,
                          ),
                          Text("Product")
                        ],
                      )),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
