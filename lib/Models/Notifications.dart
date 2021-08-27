class Notifications {
  List<NotificationList> notificationList;

  Notifications({this.notificationList});

  Notifications.fromJson(Map<String, dynamic> json) {
    if (json['notification_list'] != null) {
      notificationList = new List<NotificationList>();
      json['notification_list'].forEach((v) {
        notificationList.add(new NotificationList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.notificationList != null) {
      data['notification_list'] =
          this.notificationList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationList {
  String body;
  String date;
  String title;

  NotificationList({this.body, this.date, this.title});

  NotificationList.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    date = json['date'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['body'] = this.body;
    data['date'] = this.date;
    data['title'] = this.title;
    return data;
  }
}
