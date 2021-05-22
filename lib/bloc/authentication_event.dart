import 'package:equatable/equatable.dart';
import 'package:login/database/database_model.dart';
import 'package:login/network/api_model.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final UserDetail user;

  const LoggedIn({this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn { user: $user.username.toString() }';
}

class LoggedOut extends AuthenticationEvent {}
