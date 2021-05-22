import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:login/network/api_model.dart';

final _url = "http://ec2-3-108-41-128.ap-south-1.compute.amazonaws.com/auth";
final _loginEndpoint = '/login/';
final _logout = '/logout/';
var dio = Dio();

Future<LoginModel> getUserDetail(UserLogin userLogin) async {
  final loginUrl = _url + _loginEndpoint;

  final data = {"phone_no": userLogin.phoneNo, "password": userLogin.password};
  final resp = await dio.post(loginUrl,
      data: data,
      options: Options(headers: {"Content-Type": "multipart/form-data"}));

  print("executed, ${resp.data}");
  LoginModel decodedResp = LoginModel.fromJson(resp.data);

  return decodedResp;
}
