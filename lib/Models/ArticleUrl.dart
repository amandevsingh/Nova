class ArticleUrl {
  UserArticle userArticle;

  ArticleUrl({this.userArticle});

  ArticleUrl.fromJson(Map<String, dynamic> json) {
    userArticle = json['user_article'] != null
        ? new UserArticle.fromJson(json['user_article'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userArticle != null) {
      data['user_article'] = this.userArticle.toJson();
    }
    return data;
  }
}

class UserArticle {
  String url;

  UserArticle({this.url});

  UserArticle.fromJson(Map<String, dynamic> json) {
    url = json['url'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
