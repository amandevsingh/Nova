class TreatmentDetails {
  List<TreatmentData> treatmentData = List();

  TreatmentDetails({this.treatmentData});

  TreatmentDetails.fromJson(Map<String, dynamic> json) {
    if (json['treatment_data'] != null) {
      treatmentData = new List<TreatmentData>();
      json['treatment_data'].forEach((v) {
        treatmentData.add(new TreatmentData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.treatmentData != null) {
      data['treatment_data'] =
          this.treatmentData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TreatmentData {
  int cycle;
  String lastStatusDate;
  String lastStatus;
  String treatmentCycle;
  List<String> dates;
  List<bool> datesIsExpand = List();
  List<List<dynamic>> values;
  bool isExpand = false;

  TreatmentData(
      {this.isExpand,
      this.cycle,
      this.dates,
      this.values,
      this.lastStatusDate,
      this.datesIsExpand,
      this.lastStatus,
      this.treatmentCycle});

  TreatmentData.fromJson(Map<String, dynamic> json) {
    cycle = json['cycle'];
    isExpand = false;
    dates = json['dates'].cast<String>();
    datesIsExpand.clear();
    dates.forEach((element) {
      datesIsExpand.add(false);
    });
    lastStatusDate = json['last_status_date'] ?? "";
    lastStatus = json['last_status'] ?? "";
    treatmentCycle = json['treatment_cycle'] ?? "";
    if (json['values'] != null) {
      values = json['values'].cast<List<dynamic>>();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cycle'] = this.cycle;
    data['dates'] = this.dates;
    data['datesIsExpand'] = this.datesIsExpand;
    data['isExpand'] = this.isExpand;
    data['last_status_date'] = this.lastStatusDate;
    data['last_status'] = this.lastStatus;
    data['treatment_cycle'] = this.treatmentCycle;
    if (this.values != null) {
      data['values'] = this.values;
    }
    return data;
  }
}
