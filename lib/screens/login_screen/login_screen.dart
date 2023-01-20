import 'package:flutter/material.dart';
import 'package:minicrm/resource/image_resource.dart';
import 'package:minicrm/screens/dashboard/employee/employee_dashboard.dart';
import 'package:minicrm/utils/general_utils.dart';
import 'package:minicrm/utils/shared_pref_helper.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/LoginPage';

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscuredText = true;

  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  CRM_LOGO,
                  height: 200,
                  width: 200,
                ),
                SizedBox(
                  height: 40,
                ),
                _createUserID(),
                SizedBox(
                  height: 20,
                ),
                _createPassword(),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Flexible(
                        child: InkWell(
                          onTap: () {
                            if (_userName.text == "student" &&
                                _password.text == "student") {
                              SharedPrefHelper.instance
                                  .putBool(SharedPrefHelper.IS_LOGGED_IN, true);
                              navigateTo(context, EmployeeDashBoard.routeName);
                            } else {
                              showCommonDialogWithSingleOption(context,
                                  "Oops, Your Credentials is Incorrect !",
                                  positiveButtonTitle: "OK");
                            }
                          },
                          child: Container(
                            child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                color: Colors.blue,
                                child: Container(
                                    width: 200,
                                    height: 50,
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ))),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Container(
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              color: Colors.blue,
                              child: Container(
                                  width: 200,
                                  height: 50,
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Text(
                                      "SignUp",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _createPassword() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: _password,
        obscureText: _obscuredText,
        cursorColor: Colors.black54,
        // style: const TextStyle(color: Colors.black54),
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
        onChanged: (value) {
          /*setState(() {
            _password.text = "";
            _password.text = value;
          });*/
        },
      ),
    );
  }

  _toggle() {
    setState(() {
      _obscuredText = !_obscuredText;
    });
  }

  Widget _createUserID() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: _userName,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
          hintText: 'Enter Your Email',
        ),
      ),
    );
  }
}
