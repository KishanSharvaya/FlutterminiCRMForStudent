import 'dart:typed_data';

class InquiryProductModel {
  int id;
  int CustID;
  int Inq_id;
  String ProductName;
  int Qty;
  String UnitPrice;
  String Specification;
  String Unit;
  String NetAmount;
  Uint8List image;
  String CreatedDate;

  InquiryProductModel(
      this.CustID,
      this.Inq_id,
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
    data['Inq_id'] = this.Inq_id;
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
    return 'PlacedProductModel{id: $id, CustID:$CustID, Inq_id:$Inq_id, ProductName: $ProductName, Qty:$Qty, UnitPrice: $UnitPrice, Specification: $Specification, Unit: $Unit, NetAmount:$NetAmount, image: $image, CreatedDate: $CreatedDate}';
  }
}
