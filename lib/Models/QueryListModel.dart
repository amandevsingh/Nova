class QueryListModel {
  List<QueryNotesUserQueries> queryNotesUserQueries;

  QueryListModel({this.queryNotesUserQueries});

  QueryListModel.fromJson(Map<String, dynamic> json) {
    if (json['query_notes_user_queries'] != null) {
      queryNotesUserQueries = new List<QueryNotesUserQueries>();
      json['query_notes_user_queries'].forEach((v) {
        queryNotesUserQueries.add(new QueryNotesUserQueries.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.queryNotesUserQueries != null) {
      data['query_notes_user_queries'] =
          this.queryNotesUserQueries.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QueryNotesUserQueries {
  String id;
  bool isExpand = false;
  String queryType;
  String status;
  String title;
  String closureDate;
  QueryCenterMapping queryCenterMapping;
  Referral referral;
  List<UserQueryNotes> userQueryNotes;

  QueryNotesUserQueries(
      {this.isExpand,
      this.id,
      this.queryType,
      this.status,
      this.title,
      this.closureDate,
      this.queryCenterMapping,
      this.referral,
      this.userQueryNotes});

  QueryNotesUserQueries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isExpand = false;
    queryType = json['query_type'];
    status = json['status'];
    title = json['title'];
    closureDate = json['closure_date'];
    queryCenterMapping = json['query_center_mapping'] != null
        ? new QueryCenterMapping.fromJson(json['query_center_mapping'])
        : null;
    referral = json['referral'] != null
        ? new Referral.fromJson(json['referral'])
        : null;
    if (json['user_query_notes'] != null) {
      userQueryNotes = new List<UserQueryNotes>();
      json['user_query_notes'].forEach((v) {
        userQueryNotes.add(new UserQueryNotes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['query_type'] = this.queryType;
    data['isExpand'] = this.isExpand;
    data['status'] = this.status;
    data['title'] = this.title;
    data['closure_date'] = this.closureDate;
    if (this.queryCenterMapping != null) {
      data['query_center_mapping'] = this.queryCenterMapping.toJson();
    }
    if (this.referral != null) {
      data['referral'] = this.referral.toJson();
    }
    if (this.userQueryNotes != null) {
      data['user_query_notes'] =
          this.userQueryNotes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QueryCenterMapping {
  Centers center;

  QueryCenterMapping({this.center});

  QueryCenterMapping.fromJson(Map<String, dynamic> json) {
    center =
        json['center'] != null ? new Centers.fromJson(json['center']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.center != null) {
      data['center'] = this.center.toJson();
    }
    return data;
  }
}

class Centers {
  String id;
  String name;

  Centers({this.id, this.name});

  Centers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}

class Referral {
  int age;
  City city;
  String email;
  String gender;
  String id;
  String name;
  String phone;
  String referredDate;

  Referral(
      {this.age,
      this.city,
      this.email,
      this.gender,
      this.id,
      this.name,
      this.phone,
      this.referredDate});

  Referral.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    email = json['email'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    referredDate = json['referred_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['referred_date'] = this.referredDate;
    return data;
  }
}

class City {
  String city;
  String id;

  City({this.city, this.id});

  City.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['id'] = this.id;
    return data;
  }
}

class UserQueryNotes {
  String id;
  String remarks;
  String createdById;

  UserQueryNotes({this.id, this.remarks, this.createdById});

  UserQueryNotes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    remarks = json['remarks'];
    createdById = json['created_by_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['remarks'] = this.remarks;
    data['created_by_id'] = this.createdById;
    return data;
  }
}
