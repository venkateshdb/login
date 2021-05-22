import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:login/bloc/authentication_bloc.dart';
import 'package:login/bloc/authentication_event.dart';
import 'package:login/database/database_operation.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final DatabaseOperation databaseOperation;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    this.databaseOperation,
    this.authenticationBloc,
  }) : super(null);

  @override
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInitial();

      try {
        final user = await DatabaseOperation().authenticate(
          phone: event.phone,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(user: user));
        yield LoginInitial();
      } catch (error) {
        yield LoginFaliure(error: error.toString());
      }
    }
  }
}
