import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/inquiry/temp_inquiry_product.dart';
import 'package:minicrm/Database/table_models/product/genral_product_table.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_product/general_product_search.dart';
import 'package:minicrm/utils/full_screen_image.dart';
import 'package:minicrm/utils/general_utils.dart';
import 'package:permission_handler/permission_handler.dart';

class AddUpdateInquiryProductArguments {
  // SearchDetails editModel;

  TempInquiryProductModel editModel;
  AddUpdateInquiryProductArguments(this.editModel);
}

class InquiryProductAddEdit extends StatefulWidget {
  static const routeName = '/InquiryProductAddEdit';

  final AddUpdateInquiryProductArguments arguments;

  InquiryProductAddEdit(this.arguments);

  @override
  State<InquiryProductAddEdit> createState() => _InquiryProductAddEditState();
}

class _InquiryProductAddEditState extends State<InquiryProductAddEdit> {
  bool _obscuredText = true;

  TempInquiryProductModel _editModel;
  bool _isForUpdate = false;

  TextEditingController edt_ProductID = TextEditingController();

  TextEditingController edt_ProductName = TextEditingController();
  TextEditingController edt_Unit = TextEditingController();
  TextEditingController edt_UnitPrice = TextEditingController();
  TextEditingController edt_Specification = TextEditingController();
  TextEditingController edt_NetAmount = TextEditingController();
  TextEditingController edt_QTY = TextEditingController();

  File _selectedImageFile;
  bool is_Storage_Service_Permission;
  String ImageURLFromListing = "";

  Uint8List _bytesImage;
  bool isProductExist = false;

  @override
  void initState() {
    super.initState();

    edt_ProductName.text = "";
    edt_Unit.text = "";
    edt_UnitPrice.text = "";
    edt_Specification.text = "";
    checkPhotoPermissionStatus();

    if (widget.arguments != null) {
      _isForUpdate = true;
      _editModel = widget.arguments.editModel;

      fillData();
    } else {
      _isForUpdate = false;
    }

    edt_QTY.addListener(calculateamount);
    edt_UnitPrice.addListener(calculateamount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Add Edit"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ProductName(),
            SizedBox(
              height: 20,
            ),
            Unit(),
            SizedBox(
              height: 20,
            ),
            QTY(),
            SizedBox(
              height: 20,
            ),
            UnitPrice(),
            SizedBox(
              height: 20,
            ),
            NetAmount(),
            SizedBox(
              height: 20,
            ),
            Specification(),
            SizedBox(
              height: 20,
            ),
            Submit(context),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget ProductName() {
    return InkWell(
      onTap: () {
        if (_isForUpdate == false) {
          navigateTo(context, GeneralProductSearchScreen.routeName,
                  arguments: AddUpdateGeneralProductSearchArguments("model"))
              .then((value) {
            if (value != null) {
              ProductModel productModel = value;
              edt_ProductName.text = productModel.ProductName;
              edt_ProductID.text = productModel.id.toString();
              edt_Unit.text = productModel.Unit;
              edt_UnitPrice.text = productModel.UnitPrice;
            }

            // getDetails();
          });
        }
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: TextField(
          enabled: false,
          controller: edt_ProductName,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Product Name',
            hintText: 'Enter Your Product Name',
          ),
        ),
      ),
    );
  }

  Widget UnitPrice() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_UnitPrice,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'UnitPrice',
          hintText: '0.00',
        ),
      ),
    );
  }

  Widget NetAmount() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        enabled: false,
        controller: edt_NetAmount,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'NetAmount',
          hintText: '0.00',
        ),
      ),
    );
  }

  Widget QTY() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_QTY,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Quantity',
          hintText: '0.00',
        ),
      ),
    );
  }

  Widget Unit() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_Unit,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Unit',
          hintText: 'Enter Your Unit',
        ),
      ),
    );
  }

  Widget Specification() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: TextField(
        controller: edt_Specification,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Specification',
          hintText: 'Enter your Specification',
        ),
      ),
    );
  }

  Widget Submit(BuildContext context123) {
    return InkWell(
      onTap: () {
        if (edt_ProductName.text != "") {
          if (edt_Unit.text != "") {
            if (edt_UnitPrice.text != "") {
              if (edt_Specification.text != "") {
                AddUpdateCustomer(context123);
              } else {
                showCommonDialogWithSingleOption(
                    context, "Specification is Required !",
                    positiveButtonTitle: "OK");
              }
            } else {
              showCommonDialogWithSingleOption(
                  context, "UnitPrice is Required !",
                  positiveButtonTitle: "OK");
            }
          } else {
            showCommonDialogWithSingleOption(context, "Unit is Required !",
                positiveButtonTitle: "OK");
          }
        } else {
          showCommonDialogWithSingleOption(
              context, "Product Name is Required !",
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

  AddUpdateCustomer(BuildContext context1234) async {
    final now = new DateTime.now();
    String currentDate = DateFormat.yMd().add_jm().format(now); // 28/03/2020

    await getInquiryProductDetails();

    if (_isForUpdate == true) {
      TempInquiryProductModel UpdatecustomerModel = TempInquiryProductModel(
          0,
          0,
          edt_ProductName.text,
          int.parse(edt_QTY.text),
          edt_UnitPrice.text,
          edt_Specification.text,
          edt_Unit.text,
          edt_NetAmount.text,
          currentDate,
          id: _editModel.id);

      await OfflineDbHelper.getInstance()
          .updateTempInquiryProduct(UpdatecustomerModel);
      Navigator.of(context).pop();
    } else {
      if (isProductExist == false) {
        TempInquiryProductModel UpdatecustomerModel = TempInquiryProductModel(
            0,
            0,
            edt_ProductName.text,
            int.parse(edt_QTY.text),
            edt_UnitPrice.text,
            edt_Specification.text,
            edt_Unit.text,
            edt_NetAmount.text,
            currentDate);

        await OfflineDbHelper.getInstance()
            .insertTempInquiryProduct(UpdatecustomerModel);
        Navigator.of(context).pop();
      } else {
        showCommonDialogWithSingleOption(
            context1234, "Duplicate Product Not Allowed..!!",
            positiveButtonTitle: "OK");
      }
    }

    // ignore: use_build_context_synchronously

    // navigateTo(context, InquiryProductListScreen.routeName);
  }

  void fillData() {
    edt_ProductName.text = _editModel.ProductName;
    edt_Unit.text = _editModel.Unit;
    edt_UnitPrice.text = _editModel.UnitPrice;
    edt_QTY.text = _editModel.Qty.toString();
    edt_NetAmount.text = _editModel.NetAmount.toString();

    edt_Specification.text = _editModel.Specification;
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

  calculateamount() {
    double Qty = 0.00;
    double UnitPrice = 0.00;
    double NetAmt = 0.00;
    Qty = edt_QTY.text == "" || edt_QTY.text == null
        ? 0.00
        : double.parse(edt_QTY.text);
    UnitPrice = edt_UnitPrice.text == "" || edt_UnitPrice.text == null
        ? 0.00
        : double.parse(edt_UnitPrice.text);
    NetAmt = Qty * UnitPrice;
    edt_NetAmount.text = NetAmt.toStringAsFixed(2);
    setState(() {});
  }

  getInquiryProductDetails() async {
    List<TempInquiryProductModel> arr_tempList =
        await OfflineDbHelper.getInstance().getAllTempInquiryProduct();

    if (arr_tempList.isNotEmpty) {
      for (int i = 0; i < arr_tempList.length; i++) {
        // print("sdsdfdf"+ "TableProductID :" +  )

        if (arr_tempList[i].ProductName.toString() == edt_ProductName.text) {
          isProductExist = true;
          break;
        } else {
          isProductExist = false;
        }
      }
    } else {
      isProductExist = false;
    }
    setState(() {});
  }
}
