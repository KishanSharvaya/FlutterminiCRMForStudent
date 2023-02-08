import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/daily_activity/daily_activity_table.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/screens/dashboard/employee/daily_activity/activity_add_edit.dart';
import 'package:minicrm/screens/dashboard/employee/employee_dashboard.dart';
import 'package:minicrm/screens/dashboard/employee/followup/followup_add_edit.dart';
import 'package:minicrm/utils/general_utils.dart';

class DailyActivityListScreen extends StatefulWidget {
  static const routeName = '/DailyActivityListScreen';

  const DailyActivityListScreen({Key key}) : super(key: key);

  @override
  State<DailyActivityListScreen> createState() =>
      _DailyActivityListScreenState();
}

class _DailyActivityListScreenState extends State<DailyActivityListScreen> {
  List<DailyActivityModel> arr_CustomerList = [];
  List<DailyActivityModel> temparr_CustomerList = [];

  double _fontSize_Title = 11;
  double _fontSize_value = 15;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;

  @override
  void initState() {
    super.initState();

    getCustomerListFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Daily Activity List"),
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
                : Center(child: Text("No Customer Found")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // Add your onPressed code here!
            navigateTo(context, DailyActivityAddEdit.routeName);
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
    arr_CustomerList =
        await OfflineDbHelper.getInstance().getAllDailyActivity();
    temparr_CustomerList =
        await OfflineDbHelper.getInstance().getAllDailyActivity();
    setState(() {});
  }

  Widget Items(int index) {
    DailyActivityModel model = arr_CustomerList[index];

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
                      Icons.assignment_ind,
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
                  model.TypeOfWork,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),

          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Card(
                  color: colorBackGroundGray,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.mobile_friendly,
                              color: Color(0xff108dcf),
                              size: 24,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              model.WorkingHours,
                              style: TextStyle(
                                color: colorPrimary,
                                fontSize: _fontSize_Title,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          children: <Widget>[
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
                                                      Text("Working Notes.  ",
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
                                                          model.WorkingNotes
                                                                      .toString() ==
                                                                  ""
                                                              ? "N/A"
                                                              : model.WorkingNotes
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
                                                      Text("CreatedDate",
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
                                                          model.CreatedDate ==
                                                                  ""
                                                              ? "N/A"
                                                              : model.CreatedDate
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
                                                      Text("Created By",
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
                                                          model.CreatedBy == ""
                                                              ? "N/A"
                                                              : model.CreatedBy
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
                          navigateTo(context, DailyActivityAddEdit.routeName,
                                  arguments:
                                      AddUpdateDailyActivityArguments(model))
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
                              .deleteDailyActivity(model.id);
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
                hintText: 'Tap to Search Customer',
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
    List<DailyActivityModel> dummySearchList = [];
    dummySearchList.addAll(arr_CustomerList);
    if (enteredKeyword.isNotEmpty) {
      List<DailyActivityModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.TypeOfWork.toLowerCase()
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
