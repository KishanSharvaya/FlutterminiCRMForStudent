import 'package:flutter/material.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/screens/dashboard/customer/product_dashboard/customer_master_product_list.dart';
import 'package:minicrm/screens/dashboard/employee/customer/customer_add_edit.dart';
import 'package:minicrm/screens/dashboard/employee/customer/customer_list.dart';
import 'package:minicrm/screens/dashboard/employee/employee_dashboard.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/general_customer_search.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/inquiry_add_edit.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/inquiry_list.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/inquiry_product/inquiry_product_add_edit.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/inquiry_product/inquiry_product_list.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_product/general_product_search.dart';
import 'package:minicrm/screens/dashboard/employee/product_master/master_product_add_edit.dart';
import 'package:minicrm/screens/dashboard/employee/product_master/master_product_list.dart';
import 'package:minicrm/screens/login_screen/login_screen.dart';
import 'package:minicrm/utils/general_utils.dart';
import 'package:minicrm/utils/shared_pref_helper.dart';

import 'screens/login_screen/sign_up.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OfflineDbHelper.createInstance();
  await SharedPrefHelper.createInstance();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  _MyAppState createState() => _MyAppState();

  ///handles screen transaction based on route name
  static MaterialPageRoute globalGenerateRoute(RouteSettings settings) {
    //if screen have no argument to pass data in next screen while transiting
    // final GlobalKey<ScaffoldState> key = settings.arguments;

    switch (settings.name) {
      case LoginPage.routeName:
        return getMaterialPageRoute(LoginPage());
      case SignUpScreen.routeName:
        return getMaterialPageRoute(SignUpScreen());
      case CustomerDashBoard.routeName:
        return getMaterialPageRoute(CustomerDashBoard());
      //
      case EmployeeDashBoard.routeName:
        return getMaterialPageRoute(EmployeeDashBoard());
      case CustomerListScreen.routeName:
        return getMaterialPageRoute(CustomerListScreen());
      case CustomerAddEdit.routeName:
        return getMaterialPageRoute(CustomerAddEdit(settings.arguments));
      case GeneralProductListScreen.routeName:
        return getMaterialPageRoute(GeneralProductListScreen());

      case GeneralProductAddEdit.routeName:
        return getMaterialPageRoute(GeneralProductAddEdit(settings.arguments));

      case InquiryListScreen.routeName:
        return getMaterialPageRoute(InquiryListScreen());
      case InquiryAddEdit.routeName:
        return getMaterialPageRoute(InquiryAddEdit(settings.arguments));
      case GeneralCustomerSearchScreen.routeName:
        return getMaterialPageRoute(
            GeneralCustomerSearchScreen(settings.arguments));
      case InquiryProductListScreen.routeName:
        return getMaterialPageRoute(
            InquiryProductListScreen(settings.arguments));

      case InquiryProductAddEdit.routeName:
        return getMaterialPageRoute(InquiryProductAddEdit(settings.arguments));

      case GeneralProductSearchScreen.routeName:
        return getMaterialPageRoute(
            GeneralProductSearchScreen(settings.arguments));
      //GeneralProductSearchScreen
      default:
        return null;
    }
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /* return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomePage(),
    );*/
    return MaterialApp(
        //useInheritedMediaQuery: true,
        // builder: DevicePreview.appBuilder,
        onGenerateRoute: MyApp.globalGenerateRoute,
        debugShowCheckedModeBanner: false,
        supportedLocales: [
          Locale('en', 'US'),
        ],

        // Returns a locale which will be used by the app
        localeResolutionCallback: (locale, supportedLocales) {
          // Check if the current device locale is supported
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          // If the locale of the device is not supported, use the first one
          // from the list (English, in this case).
          return supportedLocales.first;
        },
        title: "MiniCRM",
        initialRoute: getInitialRoute());
  }

  ///returns initial route based on condition of logged in/out
  getInitialRoute() {
    /* if (SharedPrefHelper.instance.isLogIn()) {
      return HomeScreen.routeName;
    } else if (SharedPrefHelper.instance.isRegisteredIn()) {
      return FirstScreen.routeName;
    }*/

    if (SharedPrefHelper.instance.getString(SharedPrefHelper.IS_LOGGED_IN) ==
        "customer") {
      return CustomerDashBoard.routeName;
    } else if (SharedPrefHelper.instance
                .getString(SharedPrefHelper.IS_LOGGED_IN) ==
            "admin" ||
        SharedPrefHelper.instance.getString(SharedPrefHelper.IS_LOGGED_IN) ==
            "employee") {
      return EmployeeDashBoard.routeName;
    }

    return LoginPage.routeName;
  }
}
