import 'dart:convert';

List<QueryModel> queryModelListFromJson(String str) =>
    List<QueryModel>.from(json.decode(str).map((x) => QueryModel.fromJson(x)));

QueryModel queryModelFromJson(String str) =>
    QueryModel.fromJson(json.decode(str));

String queryModelToJson(QueryModel data) => json.encode(data.toJson());

class QueryModel {
  QueryModel({
    this.name,
    this.date,
    this.title,
    this.description,
    this.status,
    this.isExpand,
    this.resoultionDate,
    this.resolutionDescription,
  });

  String name;
  String date;
  String title;
  String description;
  String status;
  bool isExpand;
  String resoultionDate;
  String resolutionDescription;

  factory QueryModel.fromJson(Map<String, dynamic> json) => QueryModel(
        name: json["name"],
        date: json["date"],
        title: json["title"],
        description: json["description"],
        status: json["status"],
        isExpand: json["isExpand"],
        resoultionDate: json["resoultion_date"],
        resolutionDescription: json["resolution_description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "date": date,
        "title": title,
        "description": description,
        "status": status,
        "isExpand": isExpand,
        "resoultion_date": resoultionDate,
        "resolution_description": resolutionDescription,
      };
}
