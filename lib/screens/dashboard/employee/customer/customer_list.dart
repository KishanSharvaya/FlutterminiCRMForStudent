import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/customer/customer_tabel.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/screens/dashboard/employee/customer/customer_add_edit.dart';
import 'package:minicrm/utils/general_utils.dart';

class CustomerListScreen extends StatefulWidget {
  static const routeName = '/CustomerListScreen';

  const CustomerListScreen({Key key}) : super(key: key);

  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  List<CustomerModel> arr_CustomerList = [];
  double _fontSize_Title = 11;
  double _fontSize_value = 15;

  @override
  void initState() {
    super.initState();

    getCustomerListFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer List"),
      ),
      body: arr_CustomerList.length != 0
          ? ListView.builder(
              itemBuilder: (context, index) {
                return Items(index);
                //return Text(arr_CustomerList[index].CustomerName);
              },
              itemCount: arr_CustomerList.length,
            )
          : Center(child: Text("No Customer Found")),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // Add your onPressed code here!
          navigateTo(context, CustomerAddEdit.routeName);
        },
        child: const Icon(Icons.add),
        backgroundColor: colorPrimary,
      ),
    );
  }

  void getCustomerListFromDB() {
    getDetails();
  }

  void getDetails() async {
    arr_CustomerList.clear();
    arr_CustomerList = await OfflineDbHelper.getInstance().getAllCustomer();
    setState(() {});
  }

  Widget Items(int index) {
    CustomerModel model = arr_CustomerList[index];

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
                  model.CustomerName,
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
                              model.MobileNo1,
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
            Container(
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
              margin: EdgeInsets.only(left: 40, right: 40, top: 10, bottom: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Type",
                              style: TextStyle(
                                  fontSize: _fontSize_Title,
                                  color: colorPrimary),
                            ),
                            Text(model.CustomerType,
                                style: TextStyle(fontSize: _fontSize_value))
                          ],
                        )),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Flexible(
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Source",
                              style: TextStyle(
                                  fontSize: _fontSize_Title,
                                  color: colorPrimary),
                            ),
                            Text(model.Source,
                                style: TextStyle(fontSize: _fontSize_value))
                          ],
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Email",
                              style: TextStyle(
                                  fontSize: _fontSize_Title,
                                  color: colorPrimary),
                            ),
                            Text(model.Email,
                                style: TextStyle(fontSize: _fontSize_value))
                          ],
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: _fontSize_Title,
                                  color: colorPrimary),
                            ),
                            Text(model.Address,
                                style: TextStyle(fontSize: _fontSize_value))
                          ],
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "City",
                              style: TextStyle(
                                  fontSize: _fontSize_Title,
                                  color: colorPrimary),
                            ),
                            Text(model.City,
                                style: TextStyle(fontSize: _fontSize_value))
                          ],
                        )),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Flexible(
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "State",
                              style: TextStyle(
                                  fontSize: _fontSize_Title,
                                  color: colorPrimary),
                            ),
                            Text(model.State,
                                style: TextStyle(fontSize: _fontSize_value))
                          ],
                        )),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Country",
                              style: TextStyle(
                                  fontSize: _fontSize_Title,
                                  color: colorPrimary),
                            ),
                            Text(model.Country,
                                style: TextStyle(fontSize: _fontSize_value))
                          ],
                        )),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Flexible(
                        child: Container(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "PinCode",
                              style: TextStyle(
                                  fontSize: _fontSize_Title,
                                  color: colorPrimary),
                            ),
                            Text(model.Pincode,
                                style: TextStyle(fontSize: _fontSize_value))
                          ],
                        )),
                      ),
                    ],
                  ),
                ],
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
                          // _onTapOfEditCustomer(model);
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
                        onTap: () {
                          // _onTapOfDeleteInquiry(model.customerID);
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
}
