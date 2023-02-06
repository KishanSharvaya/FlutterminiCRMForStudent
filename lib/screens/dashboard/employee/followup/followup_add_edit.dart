import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/customer/customer_tabel.dart';
import 'package:minicrm/Database/table_models/followup/followup_tabel.dart';
import 'package:minicrm/Database/table_models/inquiry/inquiry_header.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/screens/dashboard/employee/followup/followup_list_screen.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/general_customer_search.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/inquiry_product/inquiry_product_list.dart';
import 'package:minicrm/utils/full_screen_image.dart';
import 'package:minicrm/utils/general_model/all_name_id.dart';
import 'package:minicrm/utils/general_utils.dart';
import 'package:minicrm/utils/shared_pref_helper.dart';
import 'package:permission_handler/permission_handler.dart';

class AddUpdateFollowupArguments {
  // SearchDetails editModel;

  FollowupModel editModel;
  AddUpdateFollowupArguments(this.editModel);
}

class FollowupAddEdit extends StatefulWidget {
  static const routeName = '/FollowupAddEdit';

  final AddUpdateFollowupArguments arguments;

  FollowupAddEdit(this.arguments);

  @override
  State<FollowupAddEdit> createState() => _FollowupAddEditState();
}

class _FollowupAddEditState extends State<FollowupAddEdit> {
  bool _obscuredText = true;

  FollowupModel _editModel;
  bool _isForUpdate = false;

  TextEditingController edt_customerID = TextEditingController();

  TextEditingController edt_customerName = TextEditingController();
  TextEditingController edt_Priority = TextEditingController();
  TextEditingController edt_Status = TextEditingController();
  TextEditingController edt_CloserReason = TextEditingController();

  TextEditingController edt_FollowupType = TextEditingController();
  TextEditingController edt_MeetingNotes = TextEditingController();
  TextEditingController edt_NextFollowupDate = TextEditingController();
  TextEditingController edt_LeadNo = TextEditingController();

  List<ALL_Name_ID> arr_ALL_Name_ID_For_LeadStatus = [];

  List<ALL_Name_ID> arr_ALL_Name_ID_For_Source = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_Priority = [];
  List<ALL_Name_ID> arr_ALL_Name_ID_For_CloserReason = [];

  bool isClosedLost = false;

  File _selectedImageFile;
  bool is_Storage_Service_Permission;
  String ImageURLFromListing = "";

  Uint8List _bytesImage;

  int LoginUserId = 0;
  @override
  void initState() {
    super.initState();
    BuildCustomerSource();
    BuildPriorityType();
    BuildLeadStatus();
    BuildCloserReason();

    LoginUserId =
        SharedPrefHelper.instance.getInt(SharedPrefHelper.IS_LOGGED_IN_USER_ID);

    checkPhotoPermissionStatus();
    edt_customerName.text = "";
    edt_FollowupType.text = "";
    edt_LeadNo.text = "";
    edt_MeetingNotes.text = "";

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
                  navigateTo(context, FollowupListScreen.routeName,
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
              FollowupType(),
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
              MeetingNotes(),
              SizedBox(
                height: 20,
              ),
              NextFollowupDate(),
              SizedBox(
                height: 20,
              ),
              Status(),
              SizedBox(
                height: 20,
              ),
              ClosserReason(),
              SizedBox(
                height: 20,
              ),
              uploadImage(context),
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
      onTap: () async {
        navigateTo(context, GeneralCustomerSearchScreen.routeName,
                arguments: GeneralCustomerSearchScreenArguments("model"))
            .then((value) async {
          if (value != null) {
            CustomerModel customerModel = value;
            edt_customerName.text = customerModel.CustomerName;
            edt_customerID.text = customerModel.id.toString();
            List<InquiryHeaderModel> arrInquiryList =
                await OfflineDbHelper.getInstance()
                    .getOnlyInquiryHeaderDetails(customerModel.id);

            edt_Status.text = arrInquiryList[0].LeadStatus;
            edt_CloserReason.text = arrInquiryList[0].CloserReason;
            edt_LeadNo.text = "Inq-" + arrInquiryList[0].LeadNo;
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

  Widget NextFollowupDate() {
    return InkWell(
      onTap: () {
        _selectNextFollowupDate(context, edt_NextFollowupDate);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_NextFollowupDate,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Next Followup Date',
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
        edt_NextFollowupDate.text = selectedDate.day.toString() +
            "-" +
            selectedDate.month.toString() +
            "-" +
            selectedDate.year.toString();
      });
  }

  Widget Priority() {
    return InkWell(
      onTap: () {
        showcustomListdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_Priority,
            context1: context,
            controller: edt_Priority,
            lable: "Priority");
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_Priority,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Priority',
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
        visible: true,
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

  Widget FollowupType() {
    return InkWell(
      onTap: () {
        showcustomListdialogWithOnlyName(
            values: arr_ALL_Name_ID_For_Source,
            context1: context,
            controller: edt_FollowupType,
            lable: "Followup Type");
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_FollowupType,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Followup Type',
            hintText: 'Select Followup Type',
          ),
        ),
      ),
    );
  }

  Widget MeetingNotes() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_MeetingNotes,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Meeting Notes',
          hintText: 'Enter Notes',
        ),
      ),
    );
  }

  Widget AddUpdateProduct() {
    return InkWell(
      onTap: () {
        if (edt_customerName.text != "") {
          /* showCommonDialogWithSingleOption(context, "Product Details !",
              positiveButtonTitle: "OK");*/

          // navigateTo(context, InquiryProductListScreen.routeName)

          /*int CustIDD = int.parse(edt_customerID.text.toString() == ""
              ? 0
              : edt_customerID.text.toString());*/

          navigateTo(context, InquiryProductListScreen.routeName,
                  arguments: AddUpdateInquiryProductListArguments(0, InqID: 0))
              .then((value) {
            if (value != null) {
              CustomerModel customerModel = value;
              edt_customerName.text = customerModel.CustomerName;
              edt_customerID.text = customerModel.id.toString();
              setState(() {});
            }

            // getDetails();
          });
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
            if (edt_Status.text != "") {
              if (edt_NextFollowupDate.text != "") {
                AddUpdateCustomer();
              } else {
                showCommonDialogWithSingleOption(
                    context, "Next Followup Date is Required !",
                    positiveButtonTitle: "OK");
              }
            } else {
              showCommonDialogWithSingleOption(context, "Status is Required !",
                  positiveButtonTitle: "OK");
            }
          } else {
            showCommonDialogWithSingleOption(
                context, "Priority Type is Required !",
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

    int CustID = int.parse(edt_customerID.text);
    String CustomerName = edt_customerName.text;
    String LeadPriority = edt_Priority.text;
    String LeadStatus = edt_Status.text;
    String FollowupType = edt_FollowupType.text;
    String MeetingNotes = edt_MeetingNotes.text;
    String CloserReason = edt_CloserReason.text;
    String NextFollowupDate = edt_NextFollowupDate.text;

    String LeadNo = edt_LeadNo.text;
    String CreatedBy = SharedPrefHelper.instance
        .getInt(SharedPrefHelper.IS_LOGGED_IN_USER_ID)
        .toString();
    String Customer_type =
        SharedPrefHelper.instance.getString(SharedPrefHelper.IS_LOGGED_IN);

    int returnNo = 0;

    if (_isForUpdate == true) {
      await OfflineDbHelper.getInstance().updateFollowup(FollowupModel(
        CustomerName,
        CustID,
        FollowupType,
        LeadPriority,
        LeadNo,
        MeetingNotes,
        NextFollowupDate,
        LeadStatus,
        CloserReason,
        _bytesImage,
        currentDate,
        CreatedBy,
        id: _editModel.id,
      ));
    } else {
      // await OfflineDbHelper.getInstance().insertCustomer(customerModel);
      await OfflineDbHelper.getInstance().insertFollowup(FollowupModel(
          CustomerName,
          CustID,
          FollowupType,
          LeadPriority,
          LeadNo,
          MeetingNotes,
          NextFollowupDate,
          LeadStatus,
          CloserReason,
          _bytesImage,
          currentDate,
          CreatedBy));
      print("ReturnInquiryNo" + returnNo.toString());
    }

    navigateTo(context, FollowupListScreen.routeName);
  }

  void fillData() {
    edt_FollowupType.text = _editModel.FollowUpType;
    edt_customerName.text = _editModel.CustomerName;
    edt_customerID.text = _editModel.CustID.toString();
    edt_Priority.text = _editModel.Priority;
    edt_Status.text = _editModel.InquiryStatus;
    edt_MeetingNotes.text = _editModel.MeetingNotes;
    edt_NextFollowupDate.text = _editModel.NextFollowupDate;
    edt_CloserReason.text = _editModel.CloserReason;
    _bytesImage = _editModel.image;
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, FollowupListScreen.routeName, clearAllStack: true);
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

  Widget uploadImage(BuildContext context123) {
    return Column(
      children: [
        _selectedImageFile == null
            ? _isForUpdate //edit mode or not
                ? Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: _isForUpdate == true
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 5, bottom: 5),
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: colorGray,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: ImageFullScreenWrapperWidget(
                                  child: Image.memory(
                                    _bytesImage,
                                    height: 125,
                                    width: 125,
                                  ),
                                  dark: true,
                                ),
                              ),
                            ],
                          )
                        : Container())
                : Container()
            : Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ImageFullScreenWrapperWidget(
                    child: Image.file(
                      _selectedImageFile,
                      height: 125,
                      width: 125,
                    ),
                    dark: true,
                  ),
                ),
              ),
        getCommonButton(() async {
          if (await Permission.storage.isDenied) {
            //await Permission.storage.request();

            checkPhotoPermissionStatus();
          } else {
            /* pickImage(context, onImageSelection: (file) {
              _selectedImageFile = file;
              baseBloc.refreshScreen();
            });*/

            var image2 = await ImagePicker.platform.getImage(
              source: ImageSource.gallery,
            );
            String base64Image;

            File file = File(image2.path);
            List<int> imageBytes = file.readAsBytesSync();
            print(imageBytes);
            base64Image = base64Encode(imageBytes);
            print('string is');
            print(base64Image);
            print("You selected gallery image : " + image2.path);

            _bytesImage = Base64Decoder().convert(base64Image);

            setState(() {
              _selectedImageFile = file;
            });
          }
        }, "Upload Image", backGroundColor: Colors.indigoAccent, width: 200)
      ],
    );
  }

  void checkPhotoPermissionStatus() async {
    bool granted = await Permission.storage.isGranted;
    bool Denied = await Permission.storage.isDenied;
    bool PermanentlyDenied = await Permission.storage.isPermanentlyDenied;

    print("PermissionStatus" +
        "Granted : " +
        granted.toString() +
        " Denied : " +
        Denied.toString() +
        " PermanentlyDenied : " +
        PermanentlyDenied.toString());

    if (Denied == true) {
      // openAppSettings();
      is_Storage_Service_Permission = false;

      await Permission.storage.request();

/*      showCommonDialogWithSingleOption(
          context, "Location permission is required , You have to click on OK button to Allow the location access !",
          positiveButtonTitle: "OK",
      onTapOfPositiveButton: () async {
         await openAppSettings();
         Navigator.of(context).pop();

      }

      );*/

      // await Permission.location.request();
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
    }

// You can can also directly ask the permission about its status.
    if (await Permission.location.isRestricted) {
      // The OS restricts access, for example because of parental controls.
      openAppSettings();
    }
    if (PermanentlyDenied == true) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      is_Storage_Service_Permission = false;
      openAppSettings();
    }

    if (granted == true) {
      // The OS restricts access, for example because of parental controls.
      is_Storage_Service_Permission = true;

      /*if (serviceLocation == true) {
        // Use location.
        _serviceEnabled=false;

         location.requestService();


      }
      else{
        _serviceEnabled=true;
        _getCurrentLocation();



      }*/
    }
  }
}
