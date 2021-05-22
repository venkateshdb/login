// Model to deserialize login api response
import 'dart:convert';

class UserLogin{
  String phoneNo;
  String password;

  UserLogin({this.phoneNo, this.password});
}
class LoginModel {
  String token;
  String name;
  String phoneNo;
  String referralCode;
  User user;

  LoginModel(
      {this.token, this.name, this.phoneNo, this.referralCode, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    phoneNo = json['phone_no'];
    referralCode = json['referral_code'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['referral_code'] = this.referralCode;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }

  List<LoginModel> loginFromJson(String str){
    return List<LoginModel>.from(json.decode(str).map((x) => LoginModel.fromJson(x)));
  }
}

class User {
  int id;
  String name;
  String phoneNo;
  String referralCode;
  int downloadCounts;
  Null frameDetails;

  User(
      {this.id,
        this.name,
        this.phoneNo,
        this.referralCode,
        this.downloadCounts,
        this.frameDetails});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNo = json['phone_no'];
    referralCode = json['referral_code'];
    downloadCounts = json['download_counts'];
    frameDetails = json['frame_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['referral_code'] = this.referralCode;
    data['download_counts'] = this.downloadCounts;
    data['frame_details'] = this.frameDetails;
    return data;
  }
}
