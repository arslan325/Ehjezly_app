class DoctorModel{
  static const docID = "Doctor Id";
  static const name = "Doctor Name";
  static const docImg = "Image Url";
  static const docDate = "Unavailable Dates";
  static const docTime = "Unavailable Time";
  static const treat = "Treatment";
  String? docId;
  String? docName;
  List? dateTime;
  String? docImage;
  List? treatment;
  List? unavailableTime;
  DoctorModel({
    this.docId,
    this.docName,
    this.docImage,
    this.dateTime,
    this.treatment,
    this.unavailableTime
  }
      );
  DoctorModel.fromMap(Map<String, dynamic> data){
    docId = data[docID];
    docName = data[name];
    docImage = data[docImg];
    dateTime = data[docDate];
    treatment = data[treat];
    unavailableTime = data[docTime];
  }
  toJson() {
    return {
      name : docName,
      docImg:  docImage,
      docDate:dateTime,
      treat : treatment,
      docTime:unavailableTime
    };
  }
}