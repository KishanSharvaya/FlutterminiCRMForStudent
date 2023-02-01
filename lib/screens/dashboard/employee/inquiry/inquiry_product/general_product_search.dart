import 'package:flutter/material.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/product/genral_product_table.dart';

class AddUpdateGeneralProductSearchArguments {
  // SearchDetails editModel;

  String name;
  AddUpdateGeneralProductSearchArguments(this.name);
}

class GeneralProductSearchScreen extends StatefulWidget {
  static const routeName = '/GeneralProductSearchScreen';

  final AddUpdateGeneralProductSearchArguments arguments;

  GeneralProductSearchScreen(this.arguments);
  @override
  State<GeneralProductSearchScreen> createState() =>
      _GeneralProductSearchScreenState();
}

class _GeneralProductSearchScreenState
    extends State<GeneralProductSearchScreen> {
  List<ProductModel> arr_CustomerList = [];
  List<ProductModel> temparr_CustomerList = [];

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Search"),
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

  Widget Items(int index) {
    ProductModel model = arr_CustomerList[index];

    return InkWell(
      onTap: () {
        Navigator.of(context).pop(model);
      },
      child: Container(
        child: Card(
          child: Container(
            child: Column(
              children: [Text(model.ProductName)],
            ),
          ),
        ),
      ),
    );
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
    List<ProductModel> dummySearchList = [];
    dummySearchList.addAll(arr_CustomerList);
    if (enteredKeyword.isNotEmpty) {
      List<ProductModel> dummyListData = [];
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
}
