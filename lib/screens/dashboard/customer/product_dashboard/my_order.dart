import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/product/placed_order.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/utils/full_screen_image.dart';
import 'package:minicrm/utils/shared_pref_helper.dart';

class MyOrder extends StatefulWidget {
  const MyOrder({Key key}) : super(key: key);

  @override
  State<MyOrder> createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List<PlacedProductModel> arr_CustomerList = [];
  double _fontSize_Title = 12;
  double _fontSize_value = 15;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;

  double TotalAmount = 0.00;
  double tot = 0.00;

  FToast fToast;

  int custID = 0;

  @override
  void initState() {
    super.initState();
    custID =
        SharedPrefHelper.instance.getInt(SharedPrefHelper.IS_LOGGED_IN_USER_ID);
    fToast = FToast();
    fToast.init(context);
    getCustomerListFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: arr_CustomerList.length != 0
          ? Container(
              padding: EdgeInsets.only(
                left: 5 /*DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2*/,
                right: 5 /*DEFAULT_SCREEN_LEFT_RIGHT_MARGIN2*/,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (arr_CustomerList.length != 0)
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                PlacedProductModel model =
                                    arr_CustomerList[index];

                                return Card(
                                  color: colorGreenLight,
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Flexible(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Container(
                                                  padding: EdgeInsets.all(10),
                                                  child:
                                                      ImageFullScreenWrapperWidget(
                                                    child: Image.memory(
                                                      model.image,
                                                      height: 100,
                                                      width: 100,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  top: 20, right: 10, left: 10),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("ProductName : ",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  label_color),
                                                              fontSize:
                                                                  _fontSize_Title,
                                                              letterSpacing:
                                                                  .3)),
                                                      Text(
                                                          model.ProductName ==
                                                                  ""
                                                              ? "N/A"
                                                              : model.ProductName
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  title_color),
                                                              fontSize:
                                                                  _fontSize_Title,
                                                              letterSpacing:
                                                                  .3)),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("Unit : ",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  label_color),
                                                              fontSize:
                                                                  _fontSize_Title,
                                                              letterSpacing:
                                                                  .3)),
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
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("UnitPrice : ",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  label_color),
                                                              fontSize:
                                                                  _fontSize_Title,
                                                              letterSpacing:
                                                                  .3)),
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
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text("Quantity : ",
                                                          style: TextStyle(
                                                              fontStyle:
                                                                  FontStyle
                                                                      .italic,
                                                              color: Color(
                                                                  label_color),
                                                              fontSize:
                                                                  _fontSize_Title,
                                                              letterSpacing:
                                                                  .3)),
                                                      Text(
                                                          model.Qty == ""
                                                              ? "N/A"
                                                              : model.Qty
                                                                  .toString(),
                                                          style: TextStyle(
                                                              color: Color(
                                                                  title_color),
                                                              fontSize:
                                                                  _fontSize_Title,
                                                              letterSpacing:
                                                                  .3)),
                                                    ],
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "₹ ${getPrice(double.parse(model.UnitPrice), model.Qty, model, index).toStringAsFixed(2)}",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                              shrinkWrap: true,
                              itemCount: arr_CustomerList.length,
                            )
                          else
                            Center(child: Text("No Item Found")),
                        ],
                      ),
                    ),
                  ),
                  /* if (getproductlistfromdb.length != 0)
                  Align(
                      alignment: Alignment.bottomRight,
                      child: getButtonPriceWidget())
                else
                  Container(),
                if (getproductlistfromdb.length != 0)
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: getCheckoutButton(context))
                else
                  Container()*/
                ],
              ),
            )
          : Center(
              child: Text("No Order Found"),
            ),
    );
  }

  void getCustomerListFromDB() {
    getDetails();
  }

  void getDetails() async {
    arr_CustomerList.clear();
    arr_CustomerList =
        await OfflineDbHelper.getInstance().getAllPlacedProduct(custID);

    for (int i = 0; i < arr_CustomerList.length; i++) {
      TotalAmount += (double.parse(arr_CustomerList[i].UnitPrice) *
          arr_CustomerList[i].Qty);
    }
    setState(() {});
  }

  double getPrice(double price, int itemWiseQTY,
      PlacedProductModel productCartModel, int index) {
    // TotalAmount = TotalAmount + (price * itemWiseQTY);

    // TotalAmount +=  (price * itemWiseQTY);
    //  tot = tot +  productCartModel.price * newAmount;
    tot = price * itemWiseQTY;

    // TotalAmount = TotalAmount - tot;
    double Tot1 = 0.00;

    // Tot1 += getproductlistfromdb[index].price * itemWiseQTY;
    //  TotalAmount += Tot1;

    print("GettTotal" +
        "Price : " +
        price.toStringAsFixed(2) +
        " QTY : " +
        itemWiseQTY.toString() +
        " Total Amount : " +
        Tot1.toStringAsFixed(2));

    return price * itemWiseQTY;
  }
}
