class PatientList {
  List<ReferralPatientReferrals> referralPatientReferrals;

  PatientList({this.referralPatientReferrals});

  PatientList.fromJson(Map<String, dynamic> json) {
    if (json['referral_patient_referrals'] != null) {
      referralPatientReferrals = new List<ReferralPatientReferrals>();
      json['referral_patient_referrals'].forEach((v) {
        referralPatientReferrals.add(new ReferralPatientReferrals.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.referralPatientReferrals != null) {
      data['referral_patient_referrals'] =
          this.referralPatientReferrals.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReferralPatientReferrals {
  int age;
  String email;
  String gender;
  String id;
  String name;
  String phone;
  String referredDate;
  City city;
  List<Registrations> registrations;
  ReferralCenterMapping referralCenterMapping;
  TreatmentStatus treatmentStatus;
  ReferralPatientReferrals(
      {this.age,
      this.email,
      this.gender,
      this.id,
      this.name,
      this.phone,
      this.referredDate,
      this.city,
      this.registrations,
      this.referralCenterMapping,
      this.treatmentStatus});

  ReferralPatientReferrals.fromJson(Map<String, dynamic> json) {
    age = json['age'];
    email = json['email'];
    gender = json['gender'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    referredDate = json['referred_date'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['registrations'] != null) {
      registrations = new List<Registrations>();
      json['registrations'].forEach((v) {
        registrations.add(new Registrations.fromJson(v));
      });
    }
    referralCenterMapping = json['referral_center_mapping'] != null
        ? new ReferralCenterMapping.fromJson(json['referral_center_mapping'])
        : null;
    treatmentStatus = json['treatment_status'] != null
        ? new TreatmentStatus.fromJson(json['treatment_status'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['age'] = this.age;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['referred_date'] = this.referredDate;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    if (this.registrations != null) {
      data['registrations'] =
          this.registrations.map((v) => v.toJson()).toList();
    }
    if (this.referralCenterMapping != null) {
      data['referral_center_mapping'] = this.referralCenterMapping.toJson();
    }
    if (this.treatmentStatus != null) {
      data['treatment_status'] = this.treatmentStatus.toJson();
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
    city = json['city'];
    cityCode = json['city_code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['city_code'] = this.cityCode;
    data['id'] = this.id;
    return data;
  }
}

class Registrations {
  PatientRegistration patientRegistration;

  Registrations({this.patientRegistration});

  Registrations.fromJson(Map<String, dynamic> json) {
    patientRegistration = json['patient_registration'] != null
        ? new PatientRegistration.fromJson(json['patient_registration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.patientRegistration != null) {
      data['patient_registration'] = this.patientRegistration.toJson();
    }
    return data;
  }
}

class PatientRegistration {
  String id;
  String registeredDate;
  String consultantName;

  PatientRegistration({this.id, this.registeredDate, this.consultantName});

  PatientRegistration.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    registeredDate = json['registered_date'] ?? "";
    consultantName = json['consultant_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['registered_date'] = this.registeredDate;
    data['consultant_name'] = this.consultantName;
    return data;
  }
}

class ReferralCenterMapping {
  Centers center;

  ReferralCenterMapping({this.center});

  ReferralCenterMapping.fromJson(Map<String, dynamic> json) {
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

class TreatmentStatus {
  String treatmentStatus;
  String treatmentDate;

  TreatmentStatus({this.treatmentStatus, this.treatmentDate});

  TreatmentStatus.fromJson(Map<String, dynamic> json) {
    treatmentStatus = json['treatment_status'];
    treatmentDate = json['treatment_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['treatment_status'] = this.treatmentStatus;
    data['treatment_date'] = this.treatmentDate;
    return data;
  }
}
