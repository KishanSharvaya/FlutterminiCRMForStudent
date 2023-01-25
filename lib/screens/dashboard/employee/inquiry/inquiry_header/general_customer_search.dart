import 'package:flutter/material.dart';
import 'package:minicrm/Database/offline_db_helper.dart';
import 'package:minicrm/Database/table_models/customer/customer_tabel.dart';

class GeneralCustomerSearchScreenArguments {
  // SearchDetails editModel;

  String editModel;
  GeneralCustomerSearchScreenArguments(this.editModel);
}

class GeneralCustomerSearchScreen extends StatefulWidget {
  static const routeName = '/GeneralCustomerSearchScreen';
  final GeneralCustomerSearchScreenArguments arguments;

  GeneralCustomerSearchScreen(this.arguments);

  @override
  State<GeneralCustomerSearchScreen> createState() =>
      _GeneralCustomerSearchScreenState();
}

class _GeneralCustomerSearchScreenState
    extends State<GeneralCustomerSearchScreen> {
  List<CustomerModel> arr_CustomerList = [];
  List<CustomerModel> temparr_CustomerList = [];

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
          title: Text("Customer Search"),
          actions: [
            InkWell(
                onTap: () {
                  Navigator.pop(context);
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
      ),
    );
  }

  void getCustomerListFromDB() {
    getDetails();
  }

  void getDetails() async {
    arr_CustomerList.clear();
    temparr_CustomerList.clear();
    arr_CustomerList = await OfflineDbHelper.getInstance().getAllCustomer();
    temparr_CustomerList = await OfflineDbHelper.getInstance().getAllCustomer();
    setState(() {});
  }

  Widget Items(int index) {
    CustomerModel model = arr_CustomerList[index];

    return InkWell(
      onTap: () {
        Navigator.of(context).pop(model);
      },
      child: Container(
        child: Card(
          child: Container(
            child: Column(
              children: [
                Text(model.CustomerName),
                SizedBox(
                  height: 10,
                ),
                Text(model.MobileNo1),
              ],
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
    List<CustomerModel> dummySearchList = [];
    dummySearchList.addAll(arr_CustomerList);
    if (enteredKeyword.isNotEmpty) {
      List<CustomerModel> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item.CustomerName.toLowerCase()
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
    Navigator.pop(context);

    //navigateTo(context, EmployeeDashBoard.routeName, clearAllStack: true);
  }
}
