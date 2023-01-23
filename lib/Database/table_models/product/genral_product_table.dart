import 'dart:typed_data';

class ProductModel {
  int id;
  String ProductName;
  String UnitPrice;
  String Specification;
  String Unit;
  Uint8List image;
  String CreatedDate;

  ProductModel(this.ProductName, this.UnitPrice, this.Specification, this.Unit,
      this.image, this.CreatedDate,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['ProductName'] = this.ProductName;
    data['UnitPrice'] = this.UnitPrice;
    data['Specification'] = this.Specification;
    data['Unit'] = this.Unit;
    data['image'] = this.image;
    data['CreatedDate'] = this.CreatedDate;
    return data;
  }

  @override
  String toString() {
    return 'ProductModel{id: $id, ProductName: $ProductName, UnitPrice: $UnitPrice, Specification: $Specification, Unit: $Unit, image: $image, CreatedDate: $CreatedDate}';
  }
}
