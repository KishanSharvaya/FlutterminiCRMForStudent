class CustomerModel {
  int id;
  String CustomerName;
  String Source;
  String MobileNo1;
  String MobileNo2;
  String Email;
  String Password;
  String Address;
  String City;
  String State;
  String Country;
  String Pincode;
  String CustomerType;
  String CreatedDate;

  CustomerModel(
      this.CustomerName,
      this.Source,
      this.MobileNo1,
      this.MobileNo2,
      this.Email,
      this.Password,
      this.Address,
      this.City,
      this.State,
      this.Country,
      this.Pincode,
      this.CustomerType,
      this.CreatedDate,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['CustomerName'] = this.CustomerName;
    data['Source'] = this.Source;
    data['MobileNo1'] = this.MobileNo1;
    data['MobileNo2'] = this.MobileNo2;
    data['Email'] = this.Email;
    data['Password'] = this.Password;
    data['Address'] = this.Address;
    data['City'] = this.City;
    data['State'] = this.State;
    data['Country'] = this.Country;
    data['Pincode'] = this.Pincode;
    data['CustomerType'] = this.CustomerType;
    data['CreatedDate'] = this.CreatedDate;

    return data;
  }

  @override
  String toString() {
    return 'CustomerModel{id: $id, CustomerName: $CustomerName, Source: $Source, MobileNo1: $MobileNo1, MobileNo2: $MobileNo2, Email: $Email, Password: $Password, Address: $Address, City: $City, State: $State, Country: $Country, Pincode: $Pincode , CustomerType:$CustomerType , CreatedDate: $CreatedDate}';
  }
}
