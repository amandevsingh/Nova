class UserDetails {
  List<OrgUsers> orgUsers;

  UserDetails({this.orgUsers});

  UserDetails.fromJson(Map<String, dynamic> json) {
    if (json['org_users'] != null) {
      orgUsers = new List<OrgUsers>();
      json['org_users'].forEach((v) {
        orgUsers.add(new OrgUsers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.orgUsers != null) {
      data['org_users'] = this.orgUsers.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrgUsers {
  String id;
  String name;
  String phone;
  String gender;
  String email;
  int age;
  List<UserCities> userCities;
  List<UserRoles> userRoles;

  OrgUsers(
      {this.id,
      this.name,
      this.phone,
      this.gender,
      this.email,
      this.age,
      this.userCities,
      this.userRoles});

  OrgUsers.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    phone = json['phone'] ?? "";
    gender = json['gender'] ?? "";
    email = json['email'] ?? "";
    age = json['age'] ?? 0;

    if (json['user_cities'] != null) {
      userCities = new List<UserCities>();
      json['user_cities'].forEach((v) {
        userCities.add(new UserCities.fromJson(v));
      });
    }
    if (json['user_roles'] != null) {
      userRoles = new List<UserRoles>();
      json['user_roles'].forEach((v) {
        userRoles.add(new UserRoles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['age'] = this.age;

    if (this.userCities != null) {
      data['user_cities'] = this.userCities.map((v) => v.toJson()).toList();
    }
    if (this.userRoles != null) {
      data['user_roles'] = this.userRoles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserCities {
  City city;

  UserCities({this.city});

  UserCities.fromJson(Map<String, dynamic> json) {
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    return data;
  }
}

class City {
  String city;
  String cityCode;
  String id;

  City({this.city, this.cityCode, this.id});

  City.fromJson(Map<String, dynamic> json) {
    city = json['city'] ?? "";
    cityCode = json['city_code'] ?? "";
    id = json['id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['city_code'] = this.cityCode;
    data['id'] = this.id;
    return data;
  }
}

class UserRoles {
  Role role;

  UserRoles({this.role});

  UserRoles.fromJson(Map<String, dynamic> json) {
    role = json['role'] != null ? new Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.role != null) {
      data['role'] = this.role.toJson();
    }
    return data;
  }
}

class Role {
  String name;
  String id;

  Role({this.name, this.id});

  Role.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    id = json['id'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    return data;
  }
}
