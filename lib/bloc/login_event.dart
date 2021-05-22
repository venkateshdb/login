import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String phone;
  final String password;

  const LoginButtonPressed({this.phone, this.password});

  @override
  List<Object> get props => [Icons.phone_android_outlined, password];

  @override
  String toString() =>
      'LoginButtonPressed { phone: $phone, password: $password }';
}
