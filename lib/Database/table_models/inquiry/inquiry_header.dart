class InquiryHeaderModel {
  int id;
  int CustID;
  String LeadNo;
  String CustomerName;
  String LeadPriority;
  String LeadStatus;
  String LeadSource;
  String Description;
  String CloserReason;
  String CreatedDate;
  String CreatedBy;
  String Customer_type;

  InquiryHeaderModel(
      this.CustID,
      this.LeadNo,
      this.CustomerName,
      this.LeadPriority,
      this.LeadStatus,
      this.LeadSource,
      this.Description,
      this.CloserReason,
      this.CreatedDate,
      this.CreatedBy,
      this.Customer_type,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['CustID'] = this.CustID;
    data['LeadNo'] = this.LeadNo;
    data['CustomerName'] = this.CustomerName;
    data['LeadPriority'] = this.LeadPriority;
    data['LeadStatus'] = this.LeadStatus;
    data['LeadSource'] = this.LeadSource;
    data['Description'] = this.Description;
    data['CloserReason'] = this.CloserReason;
    data['CreatedDate'] = this.CreatedDate;
    data['CreatedBy'] = this.CreatedBy;
    data['Customer_type'] = this.Customer_type;

    return data;
  }

  @override
  String toString() {
    return 'InquiryHeaderModel{id: $id, CustID: $CustID, LeadNo: $LeadNo, CustomerName: $CustomerName, LeadPriority: $LeadPriority, LeadStatus: $LeadStatus, LeadSource: $LeadSource, Description: $Description, CloserReason: $CloserReason, CreatedDate: $CreatedDate, CreatedBy: $CreatedBy, Customer_type: $Customer_type}';
  }
}
