import 'dart:convert';

List<PatientDetailModel> patientDetailModelListFromJson(String str) =>
    List<PatientDetailModel>.from(
        json.decode(str).map((x) => PatientDetailModel.fromJson(x)));

PatientDetailModel patientDetailModelFromJson(String str) =>
    PatientDetailModel.fromJson(json.decode(str));

String patientDetailModelToJson(PatientDetailModel data) =>
    json.encode(data.toJson());

class PatientDetailModel {
  PatientDetailModel({
    this.name = "",
    this.age = "",
    this.gender = "",
    this.phone = "",
    this.referredOn = "",
    this.latestDate = "",
    this.latestStatus = "",
    this.status = "",
  });

  String name;
  String age;
  String gender;
  String phone;
  String referredOn;
  String latestDate;
  String latestStatus;
  String status;

  factory PatientDetailModel.fromJson(Map<String, dynamic> json) =>
      PatientDetailModel(
        name: json["name"],
        age: json["age"],
        gender: json["gender"],
        phone: json["phone"],
        referredOn: json["referred_on"],
        latestDate: json["latest_date"],
        latestStatus: json["latest_status"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "age": age,
        "gender": gender,
        "phone": phone,
        "referred_on": referredOn,
        "latest_date": latestDate,
        "latest_status": latestStatus,
        "status": status,
      };
}
