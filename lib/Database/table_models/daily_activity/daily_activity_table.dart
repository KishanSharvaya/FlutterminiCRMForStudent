class DailyActivityModel {
  int id;
  String CreatedDate;
  String WorkingNotes;
  String TypeOfWork;
  String WorkingHours;
  String CreatedBy;

  DailyActivityModel(this.CreatedDate, this.WorkingNotes, this.TypeOfWork,
      this.WorkingHours, this.CreatedBy,
      {this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['CreatedDate'] = this.CreatedDate;
    data['WorkingNotes'] = this.WorkingNotes;
    data['TypeOfWork'] = this.TypeOfWork;
    data['WorkingHourse'] = this.WorkingHours;
    data['CreatedBy'] = this.CreatedBy;
    return data;
  }

  @override
  String toString() {
    return 'DailyActivityModel{id: $id, CreatedDate: $CreatedDate, WorkingNotes: $WorkingNotes, TypeOfWork: $TypeOfWork, WorkingHourse: $WorkingHours, CreatedBy: $CreatedBy}';
  }
}
