import 'dart:typed_data';

class CartProductModel {
  int id;
  int CustID;
  String ProductName;
  int Qty;
  String UnitPrice;
  String Specification;
  String Unit;
  String NetAmount;
  Uint8List image;
  String CreatedDate;

  CartProductModel(
      this.CustID,
      this.ProductName,
      this.Qty,
      this.UnitPrice,
      this.Specification,
      this.Unit,
      this.NetAmount,
      this.image,
      this.CreatedDate,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['CustID'] = this.CustID;
    data['ProductName'] = this.ProductName;
    data['Qty'] = this.Qty;
    data['UnitPrice'] = this.UnitPrice;
    data['Specification'] = this.Specification;
    data['Unit'] = this.Unit;
    data['NetAmount'] = this.NetAmount;
    data['image'] = this.image;
    data['CreatedDate'] = this.CreatedDate;
    return data;
  }

  @override
  String toString() {
    return 'CartProductModel{id: $id, CustID:$CustID, ProductName: $ProductName, Qty:$Qty, UnitPrice: $UnitPrice, Specification: $Specification, Unit: $Unit, NetAmount:$NetAmount, image: $image, CreatedDate: $CreatedDate}';
  }
}
