import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/product/cart_product_table.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/utils/full_screen_image.dart';
import 'package:minicrm/utils/general_utils.dart';
import 'package:minicrm/utils/item_counter_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartProductModel> arr_CustomerList = [];
  double _fontSize_Title = 12;
  double _fontSize_value = 15;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;

  double TotalAmount = 0.00;
  double tot = 0.00;

  FToast fToast;

  @override
  void initState() {
    super.initState();
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
                                CartProductModel model =
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
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  ItemCounterWidgetForCart(
                                                    onAmountChanged:
                                                        (newAmount) async {
                                                      setState(() {
                                                        //tot_amnt.text = TotalAmount.toStringAsFixed(2);
                                                        model.Qty = newAmount;

                                                        UpdateItems(model,
                                                            index, newAmount);

                                                        //ItemWiseQTY = newAmount;
                                                      });
                                                    },
                                                    amount: model.Qty,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    child: Text(
                                                      "₹ ${getPrice(double.parse(model.UnitPrice), model.Qty, model, index).toStringAsFixed(2)}",
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await OfflineDbHelper
                                                              .getInstance()
                                                          .deleteCartProduct(
                                                              model.id);

                                                      setState(() {
                                                        arr_CustomerList
                                                            .removeAt(index);
                                                        TotalAmount = 0.00;
                                                        for (int i = 0;
                                                            i <
                                                                arr_CustomerList
                                                                    .length;
                                                            i++) {
                                                          TotalAmount += (double.parse(
                                                                  arr_CustomerList[
                                                                          i]
                                                                      .UnitPrice) *
                                                              arr_CustomerList[
                                                                      i]
                                                                  .Qty);
                                                        }

                                                        // navigateTo(context, DynamicCartScreen.routeName,clearAllStack: true);
                                                      });
                                                      fToast.showToast(
                                                        child: showCustomToast(
                                                            Title:
                                                                "Item is removed from Cart !"),
                                                        gravity:
                                                            ToastGravity.BOTTOM,
                                                        toastDuration: Duration(
                                                            seconds: 2),
                                                      );
                                                    },
                                                    child: Container(
                                                      child: Card(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10)),
                                                          color: colorRed,
                                                          child: Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(10),
                                                              child: Text(
                                                                "Delete",
                                                                style: TextStyle(
                                                                    color:
                                                                        colorWhite),
                                                              ))),
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
                  arr_CustomerList.length != 0
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            children: [
                              Expanded(flex: 1, child: getButtonPriceWidget()),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                  flex: 2, child: getCheckoutButton(context))
                            ],
                          ))
                      : Container(),
                ],
              ),
            )
          : Center(
              child: Text("No Item Found"),
            ),
    );
  }

  void getCustomerListFromDB() {
    getDetails();
  }

  void getDetails() async {
    arr_CustomerList.clear();
    arr_CustomerList = await OfflineDbHelper.getInstance().getAllCartProduct();

    for (int i = 0; i < arr_CustomerList.length; i++) {
      TotalAmount += (double.parse(arr_CustomerList[i].UnitPrice) *
          arr_CustomerList[i].Qty);
    }
    setState(() {});
  }

  Future<void> UpdateItems(
      CartProductModel productCartModel, int index, newAmount) async {
    // List<ProductCartModel> tempforTotal = await OfflineDbHelper.getInstance().getProductCartList();
    TotalAmount = 0.00;
    for (int i = 0; i < arr_CustomerList.length; i++) {
      /*if(index==i)
        {*/
      // TotalAmount = TotalAmount - tempforTotal[i].price;
      TotalAmount +=
          double.parse(arr_CustomerList[i].UnitPrice) * arr_CustomerList[i].Qty;

      /* }*/
    }

    await OfflineDbHelper.getInstance().updateCartProduct(productCartModel);

    /*String name = productCartModel.ProductName;
    String Alias = productCartModel.ProductName;
    int CustomerID = productCartModel.CustID;

    String Unit = productCartModel.Unit;
    String description = productCartModel.Specification;

    double Amount = productCartModel.UnitPrice; //getTotalPrice();
    double DiscountPer = productCartModel.DiscountPercent;
    String LoginUserID = productCartModel.LoginUserID;
    String CompanyID = productCartModel.CompanyId;
    String ProductSpecification = productCartModel.ProductSpecification;
    String ProductImage = productCartModel.ProductImage;
    double vat = productCartModel.vat;

    print("ProductQNTY" + "QTY : " + productCartModel.Quantity.toString());
    // ProductCartModel productCartModel123 = new ProductCartModel(productCartModel.name,productCartModel.description,productCartModel.price,productCartModel.Qty,productCartModel.Nutritions,productCartModel.imagePath,id:getproductlistfromdb[index].id );
    ProductCartModel productCartModel12345 = new ProductCartModel(
        name,
        Alias,
        ProductID,
        CustomerID,
        Unit,
        Amount,
        productCartModel.Quantity,
        DiscountPer,
        LoginUserID,
        CompanyID,
        ProductSpecification,
        ProductImage,
        vat,
        id: getproductlistfromdb[index].id);
    await OfflineDbHelper.getInstance().updateContact(productCartModel12345);
*/
    print("Tot_Amnt456" +
        "TotAfterNetAmnout : " +
        TotalAmount.toStringAsFixed(2));
  }

  Widget getButtonPriceWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        // color: Getirblue,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Align(
        alignment: Alignment.bottomRight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Amount to be paid", style: TextStyle(fontSize: 12)),
            Text(
              "\£" + TotalAmount.toStringAsFixed(2),
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: colorBlack, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }

  Widget getCheckoutButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: getCommonButton(() {
        showCommonDialogWithSingleOption(context,
            "Your Inquiry Has been submitted , We Will Contact you soon !",
            positiveButtonTitle: "OK");
      }, "PlaceOrder"),
    );
  }

  double getPrice(double price, int itemWiseQTY,
      CartProductModel productCartModel, int index) {
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
