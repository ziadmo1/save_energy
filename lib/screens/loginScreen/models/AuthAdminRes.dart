class UserDataRes {
  String? message;
  bool? isSuccess;
  Data? data;

  UserDataRes({this.message, this.isSuccess, this.data});

  UserDataRes.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['isSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? fullName;
  String? gender;
  String? phoneNumber;
  String? email;
  bool? isAvailableToCharge;
  int? chargerEnabledAt;
  TimeRemaining? timeRemaining;

  User(
      {this.sId,
        this.fullName,
        this.gender,
        this.phoneNumber,
        this.email,
        this.isAvailableToCharge,
        this.chargerEnabledAt,
        this.timeRemaining});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
    gender = json['gender'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    isAvailableToCharge = json['isAvailableToCharge'];
    chargerEnabledAt = json['chargerEnabledAt'];
    timeRemaining = json['timeRemaining'] != null
        ? new TimeRemaining.fromJson(json['timeRemaining'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['fullName'] = this.fullName;
    data['gender'] = this.gender;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['isAvailableToCharge'] = this.isAvailableToCharge;
    data['chargerEnabledAt'] = this.chargerEnabledAt;
    if (this.timeRemaining != null) {
      data['timeRemaining'] = this.timeRemaining!.toJson();
    }
    return data;
  }
}

class TimeRemaining {
  int? hours;
  int? minutes;
  int? seconds;

  TimeRemaining({this.hours, this.minutes, this.seconds});

  TimeRemaining.fromJson(Map<String, dynamic> json) {
    hours = json['hours'];
    minutes = json['minutes'];
    seconds = json['seconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hours'] = this.hours;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    return data;
  }
}
