import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minicrm/Database/table_models/customer/customer_tabel.dart';
import 'package:minicrm/Database/table_models/inquiry/inquiry_header.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/screens/dashboard/employee/customer/customer_list.dart';
import 'package:minicrm/screens/dashboard/employee/employee_dashboard.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/general_customer_search.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/inquiry_list.dart';
import 'package:minicrm/utils/general_model/all_name_id.dart';
import 'package:minicrm/utils/general_utils.dart';

class AddUpdateInquiryArguments {
  // SearchDetails editModel;

  InquiryHeaderModel editModel;
  AddUpdateInquiryArguments(this.editModel);
}

class InquiryAddEdit extends StatefulWidget {
  static const routeName = '/InquiryAddEdit';

  final AddUpdateInquiryArguments arguments;

  InquiryAddEdit(this.arguments);

  @override
  State<InquiryAddEdit> createState() => _InquiryAddEditState();
}

class _InquiryAddEditState extends State<InquiryAddEdit> {
  bool _obscuredText = true;

  InquiryHeaderModel _editModel;
  bool _isForUpdate = false;

  TextEditingController edt_customerID = TextEditingController();

  TextEditingController edt_customerName = TextEditingController();
  TextEditingController edt_Priority = TextEditingController();
  TextEditingController edt_Status = TextEditingController();
  TextEditingController edt_CloserReason = TextEditingController();

  TextEditingController edt_Source = TextEditingController();
  TextEditingController edt_mobileNo1 = TextEditingController();
  TextEditingController edt_mobileNo2 = TextEditingController();
  TextEditingController edt_email = TextEditingController();
  TextEditingController edt_password = TextEditingController();
  TextEditingController edt_Description = TextEditingController();
  TextEditingController edt_city = TextEditingController();
  TextEditingController edt_state = TextEditingController();
  TextEditingController edt_country = TextEditingController();
  TextEditingController edt_pincode = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeadStatus = [];

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Source = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Priority = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_CloserReason = [];

  bool isClosedLost = false;

  @override
  void initState() {
    super.initState();
    BuildCustomerSource();
    BuildPriorityType();
    BuildLeadStatus();
    BuildCloserReason();
    edt_customerName.text = "";
    edt_Source.text = "";
    edt_mobileNo1.text = "";
    edt_mobileNo2.text = "";
    edt_email.text = "";
    edt_password.text = "";
    edt_Description.text = "";
    edt_city.text = "";
    edt_state.text = "";
    edt_country.text = "";
    edt_pincode.text = "";
    edt_Priority.text = "";

    if (widget.arguments != null) {
      _isForUpdate = true;
      _editModel = widget.arguments.editModel;

      fillData();
    } else {
      _isForUpdate = false;
    }

    edt_Status.addListener(() {
      if (edt_Status.text == "Closed Lost") {
        isClosedLost = true;
      } else {
        isClosedLost = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("InquiryAddEdit"),
          actions: [
            InkWell(
                onTap: () {
                  navigateTo(context, EmployeeDashBoard.routeName,
                      clearAllStack: true);
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
              Priority(),
              SizedBox(
                height: 20,
              ),
              Status(),
              SizedBox(
                height: 20,
              ),
              ClosserReason(),
              Discription(),
              SizedBox(
                height: 20,
              ),
              AddUpdateProduct(),
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
    return InkWell(
      onTap: () {
        navigateTo(context, GeneralCustomerSearchScreen.routeName,
                arguments: GeneralCustomerSearchScreenArguments("model"))
            .then((value) {
          if (value != null) {
            CustomerModel customerModel = value;
            edt_customerName.text = customerModel.CustomerName;
            edt_customerID.text = customerModel.id.toString();
          }

          // getDetails();
        });
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_customerName,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Customer Name',
            hintText: 'Tap to Search Customer',
          ),
        ),
      ),
    );
  }

  Widget Priority() {
    return InkWell(
      onTap: () {
        showcustomListdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_Priority,
            context1: context,
            controller: edt_Priority,
            lable: "Inquiry Priority");
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_Priority,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Inquiry Priority',
            hintText: 'Select Priority',
          ),
        ),
      ),
    );
  }

  Widget Status() {
    return InkWell(
      onTap: () {
        showcustomListdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_LeadStatus,
            context1: context,
            controller: edt_Status,
            lable: "Inquiry Status ");
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_Status,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Inquiry Status',
            hintText: 'Select Status',
          ),
        ),
      ),
    );
  }

  Widget ClosserReason() {
    return InkWell(
      onTap: () {
        showcustomListdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_CloserReason,
            context1: context,
            controller: edt_CloserReason,
            lable: "Closer Reason");
      },
      child: Visibility(
        visible: isClosedLost,
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: TextField(
            enabled: false,
            controller: edt_CloserReason,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Closer Reason',
              hintText: 'Select Reason',
            ),
          ),
        ),
      ),
    );
  }

  Widget Source() {
    return InkWell(
      onTap: () {
        showcustomListdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_Source,
            context1: context,
            controller: edt_Source,
            lable: "Inquiry Source ");
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_Source,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Inquiry Source',
            hintText: 'Select Inquiry Source',
          ),
        ),
      ),
    );
  }

  Widget Discription() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_Description,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Description',
          hintText: 'Enter Description',
        ),
      ),
    );
  }

  Widget AddUpdateProduct() {
    return InkWell(
      onTap: () {
        if (edt_customerName.text != "") {
          showCommonDialogWithSingleOption(context, "Product Details !",
              positiveButtonTitle: "OK");
        } else {
          showCommonDialogWithSingleOption(
              context, "Customer Name is Required !",
              positiveButtonTitle: "OK");
        }
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: 300,
        height: 60,
        child: Card(
          color: colorPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Product",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Submit() {
    return InkWell(
      onTap: () {
        if (edt_customerName.text != "") {
          if (edt_Priority.text != "") {
            if (edt_mobileNo1.text != "") {
              if (edt_email.text != "") {
                if (edt_password.text != "") {
                  if (edt_Priority.text != "") {
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
                  "Save",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BuildCustomerSource() {
    arr_ALL_Name_ID_For_Source.clear();
    for (var i = 0; i < 7; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name1 = "Mobile App";
      } else if (i == 1) {
        all_name_id.Name1 = "Walk in";
      } else if (i == 2) {
        all_name_id.Name1 = "Reference";
      } else if (i == 3) {
        all_name_id.Name1 = "By Mail";
      } else if (i == 4) {
        all_name_id.Name1 = "InProcess";
      } else if (i == 5) {
        all_name_id.Name1 = "TelePhonic";
      } else if (i == 6) {
        all_name_id.Name1 = "WebSite";
      }
      arr_ALL_Name_ID_For_Source.add(all_name_id);
    }
  }

  BuildLeadStatus() {
    arr_ALL_Name_ID_For_LeadStatus.clear();
    for (var i = 0; i < 10; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name1 = "Open";
      } else if (i == 1) {
        all_name_id.Name1 = "On Hold";
      } else if (i == 2) {
        all_name_id.Name1 = "Hold Due to Product";
      } else if (i == 3) {
        all_name_id.Name1 = "Prospect";
      } else if (i == 4) {
        all_name_id.Name1 = "No Reason";
      } else if (i == 5) {
        all_name_id.Name1 = "Call you Later";
      } else if (i == 6) {
        all_name_id.Name1 = "Busy";
      } else if (i == 7) {
        all_name_id.Name1 = "Work in Progress";
      } else if (i == 8) {
        all_name_id.Name1 = "Hold by Customer";
      } else if (i == 9) {
        all_name_id.Name1 = "Closed Lost";
      }
      arr_ALL_Name_ID_For_LeadStatus.add(all_name_id);
    }
  }

  //arr_ALL_Name_ID_For_LeadStatus

  BuildPriorityType() {
    arr_ALL_Name_ID_For_Priority.clear();
    for (var i = 0; i < 3; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name1 = "High";
      } else if (i == 1) {
        all_name_id.Name1 = "Medium";
      } else if (i == 2) {
        all_name_id.Name1 = "Low";
      }
      arr_ALL_Name_ID_For_Priority.add(all_name_id);
    }
  }

  AddUpdateCustomer() async {
    final now = new DateTime.now();
    String currentDate = DateFormat.yMd().add_jm().format(now); // 28/03/2020

    if (_isForUpdate == true) {
      //await OfflineDbHelper.getInstance().updateCustomer(UpdatecustomerModel);
    } else {
      // await OfflineDbHelper.getInstance().insertCustomer(customerModel);
    }

    navigateTo(context, CustomerListScreen.routeName);
  }

  void fillData() {
    edt_customerName.text = _editModel.CustomerName;

    edt_customerName.text = _editModel.CustomerName;
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, InquiryListScreen.routeName, clearAllStack: true);
  }

  BuildCloserReason() {
    arr_ALL_Name_ID_For_CloserReason.clear();
    for (var i = 0; i < 10; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name1 = "Not Relevant to Business";
      } else if (i == 1) {
        all_name_id.Name1 = "Plan in Future";
      } else if (i == 2) {
        all_name_id.Name1 = "Use Different Product ";
      } else if (i == 3) {
        all_name_id.Name1 = "Not Interested";
      } else if (i == 4) {
        all_name_id.Name1 = "Ringing a call";
      } else if (i == 5) {
        all_name_id.Name1 = "Number Switch Off";
      } else if (i == 6) {
        all_name_id.Name1 = "No Requirement";
      } else if (i == 7) {
        all_name_id.Name1 = "Call Back";
      } else if (i == 8) {
        all_name_id.Name1 = "No Responding";
      } else if (i == 9) {
        all_name_id.Name1 = "Low Budget";
      }
      arr_ALL_Name_ID_For_CloserReason.add(all_name_id);
    }
  }
}
