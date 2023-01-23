import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/customer/customer_tabel.dart';
import 'package:minicrm/screens/dashboard/customer/product_dashboard/customer_master_product_list.dart';
import 'package:minicrm/utils/general_utils.dart';
import 'package:minicrm/utils/shared_pref_helper.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  int custID = 0;

  List<CustomerModel> arr_customerModel = [];
  bool _obscuredText = true;

  TextEditingController edt_customerName = TextEditingController();
  TextEditingController edt_Type = TextEditingController();
  TextEditingController edt_Source = TextEditingController();
  TextEditingController edt_mobileNo1 = TextEditingController();
  TextEditingController edt_mobileNo2 = TextEditingController();
  TextEditingController edt_email = TextEditingController();
  TextEditingController edt_password = TextEditingController();
  TextEditingController edt_address = TextEditingController();
  TextEditingController edt_city = TextEditingController();
  TextEditingController edt_state = TextEditingController();
  TextEditingController edt_country = TextEditingController();
  TextEditingController edt_pincode = TextEditingController();

  @override
  void initState() {
    super.initState();
    custID =
        SharedPrefHelper.instance.getInt(SharedPrefHelper.IS_LOGGED_IN_USER_ID);
    getCustomerListFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          if (edt_Type.text != "") {
            if (edt_mobileNo1.text != "") {
              if (edt_email.text != "") {
                if (edt_password.text != "") {
                  if (edt_Type.text != "") {
                    AddUpdateCustomer();
                  } else {
                    showCommonDialogWithSingleOption(
                        context, "Customer Type is Required !",
                        positiveButtonTitle: "OK");
                  }
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
              showCommonDialogWithSingleOption(
                  context, "MobileNo1 is Required !",
                  positiveButtonTitle: "OK");
            }
          } else {
            showCommonDialogWithSingleOption(
                context, "Customer Type is Required !",
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
                  "Update",
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

    CustomerModel UpdatecustomerModel = CustomerModel(
        edt_customerName.text,
        edt_Source.text,
        edt_mobileNo1.text,
        edt_mobileNo2.text,
        edt_email.text,
        edt_password.text,
        edt_address.text,
        edt_city.text,
        edt_state.text,
        edt_country.text,
        edt_pincode.text,
        edt_Type.text,
        currentDate,
        id: custID);

    await OfflineDbHelper.getInstance().updateCustomer(UpdatecustomerModel);

    navigateTo(context, CustomerDashBoard.routeName);
  }

  void getCustomerListFromDB() {
    getDetails();
  }

  void getDetails() async {
    arr_customerModel =
        await OfflineDbHelper.getInstance().getOnlyCustomerDetails(custID);

    edt_customerName.text = arr_customerModel[0].CustomerName;
    edt_Source.text = arr_customerModel[0].Source;
    edt_mobileNo1.text = arr_customerModel[0].MobileNo1;
    edt_mobileNo2.text = arr_customerModel[0].MobileNo2;
    edt_email.text = arr_customerModel[0].Email;
    edt_password.text = arr_customerModel[0].Password;
    edt_address.text = arr_customerModel[0].Address;
    edt_city.text = arr_customerModel[0].City;
    edt_state.text = arr_customerModel[0].State;
    edt_country.text = arr_customerModel[0].Country;
    edt_pincode.text = arr_customerModel[0].Pincode;
    edt_Type.text = arr_customerModel[0].CustomerType;

    setState(() {});
  }
}
