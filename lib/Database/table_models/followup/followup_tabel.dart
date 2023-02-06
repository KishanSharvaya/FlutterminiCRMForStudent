import 'dart:typed_data';

class FollowupModel {
  int id;
  String CustomerName;
  int CustID;
  String FollowUpType;
  String Priority;
  String InqNo;
  String MeetingNotes;
  String NextFollowupDate;
  String InquiryStatus;
  String CloserReason;
  Uint8List image;
  String CreatedDate;
  String CreatedBy;

  FollowupModel(
      this.CustomerName,
      this.CustID,
      this.FollowUpType,
      this.Priority,
      this.InqNo,
      this.MeetingNotes,
      this.NextFollowupDate,
      this.InquiryStatus,
      this.CloserReason,
      this.image,
      this.CreatedDate,
      this.CreatedBy,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['CustomerName'] = this.CustomerName;
    data['CustID'] = this.CustID;
    data['FollowUpType'] = this.FollowUpType;
    data['Priority'] = this.Priority;
    data['InqNo'] = this.InqNo;
    data['MeetingNotes'] = this.MeetingNotes;
    data['NextFollowupDate'] = this.NextFollowupDate;
    data['InquiryStatus'] = this.InquiryStatus;
    data['CloserReason'] = this.CloserReason;
    data['image'] = this.image;
    data['CreatedDate'] = this.CreatedDate;
    data['CreatedBy'] = this.CreatedBy;

    return data;
  }

  @override
  String toString() {
    return 'FollowupModel{id: $id, CustomerName: $CustomerName, CustID: $CustID, FollowUpType: $FollowUpType, Priority: $Priority, InqNo: $InqNo, MeetingNotes: $MeetingNotes, NextFollowupDate: $NextFollowupDate, InquiryStatus: $InquiryStatus, CloserReason: $CloserReason, image: $image, CreatedDate: $CreatedDate, CreatedBy: $CreatedBy}';
  }
}
