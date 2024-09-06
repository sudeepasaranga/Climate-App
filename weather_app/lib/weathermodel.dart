class ApiResponse {
  Location? location;
  Current? current;
  Alerts? alerts;

  ApiResponse({this.location, this.current, this.alerts});

  ApiResponse.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    current =
        json['current'] != null ? new Current.fromJson(json['current']) : null;
    alerts =
        json['alerts'] != null ? Alerts.fromJson(json['alerts']) : null;  // Parse alerts if present
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.current != null) {
      data['current'] = this.current!.toJson();
    }
     if (this.alerts != null) {
      data['alerts'] = this.alerts!.toJson();  // Add alerts to the JSON map
    }
    return data;
  }
}

class Location {
  String? name;
  String? country;
  String? localtime;

  Location({this.name, this.country, this.localtime});

  Location.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    country = json['country'];
    localtime = json['localtime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['country'] = this.country;
    data['localtime'] = this.localtime;
    return data;
  }
}

class Current {
  double? tempC;
  int? isDay;
  Condition? condition;
  double? windKph;
  double? precipMm;
  int? humidity;
  double? uv;

  Current(
      {this.tempC,
      this.isDay,
      this.condition,
      this.windKph,
      this.precipMm,
      this.humidity,
      this.uv});

  Current.fromJson(Map<String, dynamic> json) {
    tempC = json['temp_c'];
    isDay = json['is_day'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    windKph = json['wind_kph'];
    precipMm = json['precip_mm'];
    humidity = json['humidity'];
    uv = json['uv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp_c'] = this.tempC;
    data['is_day'] = this.isDay;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['wind_kph'] = this.windKph;
    data['precip_mm'] = this.precipMm;
    data['humidity'] = this.humidity;
    data['uv'] = this.uv;
    return data;
  }
}

class Condition {
  String? text;
  String? icon;
  int? code;

  Condition({this.text, this.icon, this.code});

  Condition.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    icon = json['icon'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['icon'] = this.icon;
    data['code'] = this.code;
    return data;
  }

}


// New class for Weather Alerts
class Alerts {
  List<Alert>? alert;

  Alerts({this.alert});

  Alerts.fromJson(Map<String, dynamic> json) {
    if (json['alert'] != null) {
      alert = <Alert>[];
      json['alert'].forEach((v) {
        alert!.add(Alert.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alert != null) {
      data['alert'] = this.alert!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alert {
  String? headline;
  String? msgType;
  String? severity;
  String? urgency;
  String? areas;
  String? category;
  String? certainty;
  String? event;
  String? note;
  String? effective;
  String? expires;
  String? desc;
  String? instruction;

  Alert(
      {this.headline,
      this.msgType,
      this.severity,
      this.urgency,
      this.areas,
      this.category,
      this.certainty,
      this.event,
      this.note,
      this.effective,
      this.expires,
      this.desc,
      this.instruction});

  Alert.fromJson(Map<String, dynamic> json) {
    headline = json['headline'];
    msgType = json['msg_type'];
    severity = json['severity'];
    urgency = json['urgency'];
    areas = json['areas'];
    category = json['category'];
    certainty = json['certainty'];
    event = json['event'];
    note = json['note'];
    effective = json['effective'];
    expires = json['expires'];
    desc = json['desc'];
    instruction = json['instruction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['headline'] = this.headline;
    data['msg_type'] = this.msgType;
    data['severity'] = this.severity;
    data['urgency'] = this.urgency;
    data['areas'] = this.areas;
    data['category'] = this.category;
    data['certainty'] = this.certainty;
    data['event'] = this.event;
    data['note'] = this.note;
    data['effective'] = this.effective;
    data['expires'] = this.expires;
    data['desc'] = this.desc;
    data['instruction'] = this.instruction;
    return data;
  }
}