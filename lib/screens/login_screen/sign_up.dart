import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/customer/customer_tabel.dart';
import 'package:minicrm/screens/login_screen/login_screen.dart';
import 'package:minicrm/utils/general_model/all_name_id.dart';
import 'package:minicrm/utils/general_utils.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscuredText = true;

  TextEditingController edt_customerName = TextEditingController();
  TextEditingController edt_mobileNo1 = TextEditingController();
  TextEditingController edt_mobileNo2 = TextEditingController();
  TextEditingController edt_email = TextEditingController();
  TextEditingController edt_password = TextEditingController();
  TextEditingController edt_address = TextEditingController();
  TextEditingController edt_city = TextEditingController();
  TextEditingController edt_state = TextEditingController();
  TextEditingController edt_country = TextEditingController();
  TextEditingController edt_pincode = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Source = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Type = [];

  @override
  void initState() {
    super.initState();
    edt_customerName.text = "";
    edt_mobileNo1.text = "";
    edt_mobileNo2.text = "";
    edt_email.text = "";
    edt_password.text = "";
    edt_address.text = "";
    edt_city.text = "";
    edt_state.text = "";
    edt_country.text = "";
    edt_pincode.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("SignUp"),
          actions: [
            InkWell(
                onTap: () {
                  navigateTo(context, LoginPage.routeName, clearAllStack: true);
                },
                child: Icon(Icons.home)),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CustomerName(),
              SizedBox(
                height: 20,
              ),
              MobileNo1(),
              SizedBox(
                height: 20,
              ),
              MobileNo2(),
              SizedBox(
                height: 20,
              ),
              EmailAddress(),
              SizedBox(
                height: 20,
              ),
              Password(),
              SizedBox(
                height: 20,
              ),
              Address(),
              SizedBox(
                height: 20,
              ),
              City(),
              SizedBox(
                height: 20,
              ),
              State(),
              SizedBox(
                height: 20,
              ),
              Country(),
              SizedBox(
                height: 20,
              ),
              PinCode(),
              SizedBox(
                height: 20,
              ),
              Submit(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget CustomerName() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_customerName,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Customer Name',
          hintText: 'Enter Your Name',
        ),
      ),
    );
  }

  Widget MobileNo1() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_mobileNo1,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'MobileNo1',
          hintText: 'Enter Your MobileNo',
        ),
      ),
    );
  }

  Widget MobileNo2() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_mobileNo2,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'MobileNo2',
          hintText: 'Enter Your MobileNumber',
        ),
      ),
    );
  }

  Widget EmailAddress() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_email,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          hintText: 'Enter Your Email',
        ),
      ),
    );
  }

  Widget Password() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_password,
        obscureText: _obscuredText,
        cursorColor: Colors.black54,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
            labelStyle: const TextStyle(color: Colors.black54),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black54)),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            labelText: 'Password',
            hintText: 'Password',
            suffixIcon: IconButton(
                onPressed: _toggle,
                icon: Icon(Icons.remove_red_eye,
                    color: _obscuredText ? Colors.black12 : Colors.black54))),
      ),
    );
  }

  Widget Address() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_address,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Address',
          hintText: 'Enter your Address',
        ),
      ),
    );
  }

  Widget City() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_city,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'City',
          hintText: 'Enter Your City',
        ),
      ),
    );
  }

  Widget State() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_state,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'State',
          hintText: 'Enter Your State',
        ),
      ),
    );
  }

  Widget Country() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_country,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Country',
          hintText: 'Enter Your Country',
        ),
      ),
    );
  }

  Widget PinCode() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_pincode,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'PinCode',
          hintText: 'Enter Your PinCode',
        ),
      ),
    );
  }

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  Widget Submit() {
    return InkWell(
      onTap: () {
        if (edt_customerName.text != "") {
          if (edt_mobileNo1.text != "") {
            if (edt_email.text != "") {
              if (edt_password.text != "") {
                AddUpdateCustomer();
              } else {
                showCommonDialogWithSingleOption(
                    context, "Password is Required !",
                    positiveButtonTitle: "OK");
              }
            } else {
              showCommonDialogWithSingleOption(context, "Email is Required !",
                  positiveButtonTitle: "OK");
            }
          } else {
            showCommonDialogWithSingleOption(context, "MobileNo1 is Required !",
                positiveButtonTitle: "OK");
          }
        } else {
          showCommonDialogWithSingleOption(
              context, "Customer Name is Required !",
              positiveButtonTitle: "OK");
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: double.infinity,
        height: 60,
        child: Card(
          color: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Register",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AddUpdateCustomer() async {
    final now = new DateTime.now();
    String currentDate = DateFormat.yMd().add_jm().format(now); // 28/03/2020

    CustomerModel customerModel = CustomerModel(
      edt_customerName.text,
      "Mobile App",
      edt_mobileNo1.text,
      edt_mobileNo2.text,
      edt_email.text,
      edt_password.text,
      edt_address.text,
      edt_city.text,
      edt_state.text,
      edt_country.text,
      edt_pincode.text,
      "customer",
      currentDate,
    );

    await OfflineDbHelper.getInstance().insertCustomer(customerModel);
    navigateTo(context, LoginPage.routeName, clearAllStack: true);
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, LoginPage.routeName, clearAllStack: true);
  }
}
