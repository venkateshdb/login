import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:login/database/database_operation.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final DatabaseOperation databaseOperation ;
  
  AuthenticationBloc({this.databaseOperation}) : super(null);

  @override
  AuthenticationState get initialState => AuthenticationUnintialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      final bool hasToken = await databaseOperation.hasToken(0);

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();

      await databaseOperation.createUser(event.user); // save user to db
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();

      await databaseOperation.deleteUser(0);

      yield AuthenticationUnauthenticated();
    }
  }
}
