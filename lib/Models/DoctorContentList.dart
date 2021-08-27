class DoctorContentList {
  List<DataUserContent> dataUserContent;

  DoctorContentList({this.dataUserContent});

  DoctorContentList.fromJson(Map<String, dynamic> json) {
    if (json['data_user_content'] != null) {
      dataUserContent = new List<DataUserContent>();
      json['data_user_content'].forEach((v) {
        dataUserContent.add(new DataUserContent.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dataUserContent != null) {
      data['data_user_content'] =
          this.dataUserContent.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataUserContent {
  String id;
  String imgUrl;
  String title;
  String description;
  String articleUrl;
  String createdAt;

  DataUserContent(
      {this.id,
      this.imgUrl,
      this.title,
      this.description,
      this.articleUrl,
      this.createdAt});

  DataUserContent.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgUrl = json['img_url'];
    title = json['title'];
    description = json['description'];
    articleUrl = json['article_url'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['img_url'] = this.imgUrl;
    data['title'] = this.title;
    data['description'] = this.description;
    data['article_url'] = this.articleUrl;
    data['created_at'] = this.createdAt;
    return data;
  }
}
