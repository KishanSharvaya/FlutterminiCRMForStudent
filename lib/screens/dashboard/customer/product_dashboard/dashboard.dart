import 'package:flutter/material.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/product/genral_product_table.dart';
import 'package:minicrm/resource/color_resource.dart';
import 'package:minicrm/utils/full_screen_image.dart';
import 'package:minicrm/utils/general_utils.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final double runSpacing = 4;
  final double spacing = 4;
  final columns = 4;

  double _fontSize_Title = 12;
  double _fontSize_value = 15;

  double sizeboxsize = 12;
  double _fontSize_Label = 9;
  int label_color = 0xff4F4F4F; //0x66666666;
  int title_color = 0xff362d8b;

  List<ProductModel> arr_CustomerList = [];
  List<ProductModel> temparr_CustomerList = [];
  @override
  void initState() {
    super.initState();

    getCustomerListFromDB();
  }

  @override
  Widget build(BuildContext context) {
    // final w = (MediaQuery.of(context).size.width - runSpacing * (4 - 1)) / 4;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            ProductModel model = arr_CustomerList[index];

            return Card(
              color: colorGreenLight,
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Card(
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
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20, right: 10, left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("ProductName : ",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                  Text(
                                      model.ProductName == ""
                                          ? "N/A"
                                          : model.ProductName.toString(),
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Unit : ",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                  Text(
                                      model.Unit == ""
                                          ? "N/A"
                                          : model.Unit.toString(),
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("UnitPrice : ",
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(label_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                  Text(
                                      model.UnitPrice == ""
                                          ? "N/A"
                                          : model.UnitPrice.toString(),
                                      style: TextStyle(
                                          color: Color(title_color),
                                          fontSize: _fontSize_Title,
                                          letterSpacing: .3)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              getCommonButton(() {}, "Add to Cart",
                                  radius: 20, height: 35, width: 150)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
            //return Text(arr_CustomerList[index].CustomerName);
          },
          itemCount: arr_CustomerList.length,
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
        await OfflineDbHelper.getInstance().getAllGeneralProduct();
    temparr_CustomerList =
        await OfflineDbHelper.getInstance().getAllGeneralProduct();
    setState(() {});
  }
}
