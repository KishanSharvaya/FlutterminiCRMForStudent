import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/daily_activity/daily_activity_table.dart';
import 'package:minicrm/screens/dashboard/employee/daily_activity/activity_list.dart';
import 'package:minicrm/utils/general_model/all_name_id.dart';
import 'package:minicrm/utils/general_utils.dart';
import 'package:minicrm/utils/shared_pref_helper.dart';

class AddUpdateDailyActivityArguments {
  // SearchDetails editModel;

  DailyActivityModel editModel;

  AddUpdateDailyActivityArguments(this.editModel);
}

class DailyActivityAddEdit extends StatefulWidget {
  static const routeName = '/DailyActivityAddEdit';

  final AddUpdateDailyActivityArguments arguments;

  DailyActivityAddEdit(this.arguments);

  @override
  State<DailyActivityAddEdit> createState() => _DailyActivityAddEditState();
}

class _DailyActivityAddEditState extends State<DailyActivityAddEdit> {
  bool _obscuredText = true;

  DailyActivityModel _editModel;
  bool _isForUpdate = false;

  TextEditingController edt_TypeOfWork = TextEditingController();
  TextEditingController edt_WorkingNotes = TextEditingController();
  TextEditingController edt_WorkingHours = TextEditingController();

  TextEditingController edt_CretaedDate = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_TypeOfWork = [];

  bool isClosedLost = false;

  File _selectedImageFile;
  bool is_Storage_Service_Permission;
  String ImageURLFromListing = "";

  Uint8List _bytesImage;

  int LoginUserId = 0;

  @override
  void initState() {
    super.initState();
    BuildTypeOfWork();

    LoginUserId =
        SharedPrefHelper.instance.getInt(SharedPrefHelper.IS_LOGGED_IN_USER_ID);

    edt_TypeOfWork.text = "";
    edt_WorkingNotes.text = "";
    edt_WorkingHours.text = "";
    edt_CretaedDate.text = "";

    if (widget.arguments != null) {
      _isForUpdate = true;
      _editModel = widget.arguments.editModel;

      fillData();
    } else {
      _isForUpdate = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("DailyActivity AddEdit"),
          actions: [
            InkWell(
                onTap: () {
                  navigateTo(context, DailyActivityListScreen.routeName,
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
              CreatedDate(),
              SizedBox(
                height: 20,
              ),
              TypeOfWorkList(),
              SizedBox(
                height: 20,
              ),
              WorkingNotes(),
              SizedBox(
                height: 20,
              ),
              WorkingHours(),
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

  Widget CreatedDate() {
    return InkWell(
      onTap: () {
        _selectNextFollowupDate(context, edt_CretaedDate);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_CretaedDate,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Created Date',
            hintText: 'DD-MM-YYYY',
          ),
        ),
      ),
    );
  }

  Future<void> _selectNextFollowupDate(
      BuildContext context, TextEditingController F_datecontroller) async {
    DateTime selectedDate = DateTime.now();

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: selectedDate,
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        edt_CretaedDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
      });
  }

  Widget TypeOfWorkList() {
    return InkWell(
      onTap: () {
        showcustomListdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_TypeOfWork,
            context1: context,
            controller: edt_TypeOfWork,
            lable: "Type Of Work");
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_TypeOfWork,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Type Of Work',
            hintText: 'Select Type Of Work',
          ),
        ),
      ),
    );
  }

  Widget WorkingNotes() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_WorkingNotes,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Working Notes',
          hintText: 'Enter Notes',
        ),
      ),
    );
  }

  Widget WorkingHours() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_WorkingHours,
        maxLines: null,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Working Hours',
          hintText: 'Enter Hours',
        ),
      ),
    );
  }

  Widget Submit() {
    return InkWell(
      onTap: () {
        if (edt_CretaedDate.text != "") {
          if (edt_TypeOfWork.text != "") {
            if (edt_WorkingNotes.text != "") {
              if (edt_WorkingHours.text != "") {
                AddUpdateCustomer();
              } else {
                showCommonDialogWithSingleOption(
                    context, "Working Hours is Required !",
                    positiveButtonTitle: "OK");
              }
            } else {
              showCommonDialogWithSingleOption(
                  context, "Working Notes is Required !",
                  positiveButtonTitle: "OK");
            }
          } else {
            showCommonDialogWithSingleOption(
                context, "Type Of Work is Required !",
                positiveButtonTitle: "OK");
          }
        } else {
          showCommonDialogWithSingleOption(
              context, "Created Date is Required !",
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

  BuildTypeOfWork() {
    arr_ALL_Name_ID_For_TypeOfWork.clear();
    for (var i = 0; i < 11; i++) {
      ALL_Name_ID all_name_id = ALL_Name_ID();

      if (i == 0) {
        all_name_id.Name1 = "ACCOUNT";
      } else if (i == 1) {
        all_name_id.Name1 = "ADMINISTRATION";
      } else if (i == 2) {
        all_name_id.Name1 = "CLIENT VISIT";
      } else if (i == 3) {
        all_name_id.Name1 = "COMMUNICATION";
      } else if (i == 4) {
        all_name_id.Name1 = "DEVELOPMENT";
      } else if (i == 5) {
        all_name_id.Name1 = "MEETING";
      } else if (i == 6) {
        all_name_id.Name1 = "PROJECT DISCUSSION";
      } else if (i == 7) {
        all_name_id.Name1 = "R & D";
      } else if (i == 8) {
        all_name_id.Name1 = "REVIEW";
      } else if (i == 9) {
        all_name_id.Name1 = "TELEPHONIC";
      } else if (i == 10) {
        all_name_id.Name1 = "SUPPORT";
      }
      arr_ALL_Name_ID_For_TypeOfWork.add(all_name_id);
    }
  }

  //arr_ALL_Name_ID_For_LeadStatus

  AddUpdateCustomer() async {
    final now = new DateTime.now();
    String currentDate = DateFormat.yMd().add_jm().format(now); // 28/03/2020

    String TypeOfWork = edt_TypeOfWork.text;
    String WorkingNotes = edt_WorkingNotes.text;
    String WorkingHours = edt_WorkingHours.text;
    String CreatedDate = edt_CretaedDate.text;

    String CreatedBy = SharedPrefHelper.instance
        .getInt(SharedPrefHelper.IS_LOGGED_IN_USER_ID)
        .toString();

    int returnNo = 0;

    if (_isForUpdate == true) {
      await OfflineDbHelper.getInstance()
          .updateDailyActivity(DailyActivityModel(
        CreatedDate,
        WorkingNotes,
        TypeOfWork,
        WorkingHours,
        CreatedBy,
        id: _editModel.id,
      ));
    } else {
      // await OfflineDbHelper.getInstance().insertCustomer(customerModel);
      await OfflineDbHelper.getInstance()
          .insertDailyActivity(DailyActivityModel(
        CreatedDate,
        WorkingNotes,
        TypeOfWork,
        WorkingHours,
        CreatedBy,
      ));
      print("ReturnInquiryNo" + returnNo.toString());
    }

    navigateTo(context, DailyActivityListScreen.routeName);
  }

  void fillData() {
    edt_TypeOfWork.text = _editModel.TypeOfWork;
    edt_WorkingNotes.text = _editModel.WorkingNotes;
    edt_WorkingHours.text = _editModel.WorkingHours;
    edt_CretaedDate.text = _editModel.CreatedDate;
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, DailyActivityListScreen.routeName, clearAllStack: true);
  }
}
