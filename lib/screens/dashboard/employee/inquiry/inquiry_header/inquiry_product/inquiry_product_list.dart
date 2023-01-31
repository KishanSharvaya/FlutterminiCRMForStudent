import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/inquiry/inquiry_product.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/screens/dashboard/employee/employee_dashboard.dart';
import 'package:minicrm/screens/dashboard/employee/inquiry/inquiry_header/inquiry_product/inquiry_product_add_edit.dart';
import 'package:minicrm/utils/full_screen_image.dart';
import 'package:minicrm/utils/general_utils.dart';

class AddUpdateInquiryProductListArguments {
  // SearchDetails editModel;

  int custID;
  int InqID;
  AddUpdateInquiryProductListArguments(this.custID, {this.InqID});
}

class InquiryProductListScreen extends StatefulWidget {
  static const routeName = '/InquiryProductListScreen';

  final AddUpdateInquiryProductListArguments arguments;

  InquiryProductListScreen(this.arguments);

  @override
  State<InquiryProductListScreen> createState() =>
      _InquiryProductListScreenState();
}

class _InquiryProductListScreenState extends State<InquiryProductListScreen> {
  List<InquiryProductModel> arr_CustomerList = [];
  List<InquiryProductModel> temparr_CustomerList = [];

  int _cutID = 0;
  int _InqID = 0;

  double _fontSize_Title = 11;
  double _fontSize_value = 15;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;

  @override
  void initState() {
    super.initState();
    _cutID = widget.arguments.custID;
    _InqID = widget.arguments.InqID == null ? 0 : widget.arguments.InqID;
    getCustomerListFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Inquiry Product List"),
          actions: [
            InkWell(
                onTap: () {
                  navigateTo(context, EmployeeDashBoard.routeName,
                      clearAllStack: true);
                },
                child: Icon(Icons.home)),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text("df"),
            SearchTextField(),
            arr_CustomerList.length != 0
                ? Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Items(index);
                        //return Text(arr_CustomerList[index].CustomerName);
                      },
                      itemCount: arr_CustomerList.length,
                    ),
                  )
                : Center(child: Text("No Product Found")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Add your onPressed code here!
            navigateTo(context, InquiryProductAddEdit.routeName);
          },
          child: const Icon(Icons.add),
          backgroundColor: colorPrimary,
        ),
      ),
    );
  }

  void getCustomerListFromDB() {
    getDetails();
  }

  void getDetails() async {
    arr_CustomerList.clear();
    temparr_CustomerList.clear();

    if (_InqID != 0 || _InqID != null) {
      arr_CustomerList =
          await OfflineDbHelper.getInstance().getAllInquiryProduct(_InqID);
      temparr_CustomerList =
          await OfflineDbHelper.getInstance().getAllInquiryProduct(_InqID);
    } else {
      arr_CustomerList = await OfflineDbHelper.getInstance()
          .getAllCustomerInquiryProduct(_cutID);
      temparr_CustomerList = await OfflineDbHelper.getInstance()
          .getAllCustomerInquiryProduct(_cutID);
    }

    //

    setState(() {});
  }

  Widget Items(int index) {
    InquiryProductModel model = arr_CustomerList[index];

    return Container(
        padding: EdgeInsets.all(15),
        child: ExpansionTileCard(
          // key:Key(index.toString()),
          initialElevation: 5.0,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          elevation: 1,
          elevationCurve: Curves.easeInOut,
          shadowColor: Color(0xFF504F4F),
          baseColor: Color(0xFFFCFCFC),
          expandedColor: colorTileBG,
          /* leading: Image.network(
            "http://demo.sharvayainfotech.in/images/profile.png",
            height: 35,
            width: 35,
          ),*/
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.card_travel,
                      color: Color(0xff108dcf),
                      size: 24,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Container(
                margin: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.keyboard_arrow_right,
                  color: Color(0xff108dcf),
                  size: 24,
                ),
              ),
              SizedBox(
                width: 3,
              ),
              Flexible(
                child: Text(
                  model.ProductName,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                padding: EdgeInsets.all(10),
                child: ImageFullScreenWrapperWidget(
                  child: Image.memory(
                    model.image,
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Container(
                    margin: EdgeInsets.all(20),
                    child: Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("Unit",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  label_color),
                                                              fontSize:
                                                                  _fontSize_Label,
                                                              letterSpacing:
                                                                  .3)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          model.Unit == ""
                                                              ? "N/A"
                                                              : model.Unit
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  title_color),
                                                              fontSize:
                                                                  _fontSize_Title,
                                                              letterSpacing:
                                                                  .3)),
                                                    ],
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("Unit Price",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  label_color),
                                                              fontSize:
                                                                  _fontSize_Label,
                                                              letterSpacing:
                                                                  .3)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          model.UnitPrice == ""
                                                              ? "N/A"
                                                              : model.UnitPrice
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  title_color),
                                                              fontSize:
                                                                  _fontSize_Title,
                                                              letterSpacing:
                                                                  .3)),
                                                    ],
                                                  )),
                                            ]),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: sizeboxsize,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Expanded(
                                                  flex: 1,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("Specification",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  label_color),
                                                              fontSize:
                                                                  _fontSize_Label,
                                                              letterSpacing:
                                                                  .3)),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                          model.Specification ==
                                                                  ""
                                                              ? "N/A"
                                                              : model.Specification
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  title_color),
                                                              fontSize:
                                                                  _fontSize_Title,
                                                              letterSpacing:
                                                                  .3)),
                                                    ],
                                                  )),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ))),
              ),
            ),
            Divider(
              thickness: 1.0,
              height: 1.0,
            ),
            SizedBox(
              height: 10,
            ),
            Card(
              color: colorCardBG,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                width: 300,
                height: 50,
                child: ButtonBar(
                    alignment: MainAxisAlignment.spaceBetween,
                    buttonHeight: 52.0,
                    buttonMinWidth: 90.0,
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateTo(context, InquiryProductAddEdit.routeName,
                                  arguments:
                                      AddUpdateInquiryProductArguments(model))
                              .then((value) {
                            getDetails();
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.edit,
                              size: 24,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                            ),
                            Text(
                              'Update',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: colorWhite),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () async {
                          // _onTapOfDeleteInquiry(model.customerID);
                          await OfflineDbHelper.getInstance()
                              .deleteGeneralProduct(model.id);
                          getDetails();
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.delete,
                              size: 24,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2.0),
                            ),
                            Text(
                              'Delete',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: colorWhite),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ]),
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ));
  }

  Widget SearchTextField() {
    return Container(
      height: 60,
      margin: EdgeInsets.all(10),
      child: Card(
        child: Container(
          child: TextField(
            onChanged: (value) {
              setState(() {
                SearchResult(value);
              });
            },
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 10, top: 15),
                border: InputBorder.none,
                // labelText: 'Search',
                hintText: 'Tap to Search Product',
                suffixIcon: Icon(
                  Icons.search,
                  color: Color(0xff070241),
                )),
          ),
        ),
      ),
    );
  }

  void SearchResult(String enteredKeyword) {
    List<InquiryProductModel> dummySearchList = [];
    dummySearchList.addAll(arr_CustomerList);
    if (enteredKeyword.isNotEmpty) {
      List<InquiryProductModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.ProductName.toLowerCase()
            .contains(enteredKeyword.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        arr_CustomerList.clear();
        arr_CustomerList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        arr_CustomerList.clear();
        arr_CustomerList.addAll(temparr_CustomerList);
      });
    }
  }

  Future<bool> _onBackPressed() {
    navigateTo(context, EmployeeDashBoard.routeName, clearAllStack: true);
  }
}
