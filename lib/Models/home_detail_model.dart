import 'dart:convert';

HomeDetailModel homeDetailModelFromJson(String str) =>
    HomeDetailModel.fromJson(json.decode(str));

String homeDetailModelToJson(HomeDetailModel data) =>
    json.encode(data.toJson());

class HomeDetailModel {
  HomeDetailModel({
    this.imgUrl = "",
    this.title = "",
    this.description = "",
    this.date = "",
  });

  String imgUrl;
  String title;
  String description;
  String date;

  factory HomeDetailModel.fromJson(Map<String, dynamic> json) =>
      HomeDetailModel(
        imgUrl: json["img_url"],
        title: json["title"],
        description: json["description"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "img_url": imgUrl,
        "title": title,
        "description": description,
        "date": date,
      };
}
