import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/authentication_state.dart';
import 'package:login/database/database_operation.dart';

import 'package:login/bloc/authentication_bloc.dart';
import 'package:login/bloc/authentication_event.dart';
import 'package:login/screen/splash.dart';
import 'package:login/screen/login_page.dart';
import 'package:login/screen/home.dart';
import 'package:login/screen/loading.dart';

void main() {
  final databaseOperation = DatabaseOperation();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      return AuthenticationBloc(databaseOperation: databaseOperation)
        ..add(AppStarted());
    },
    child: App(databaseOperation: databaseOperation),
  ));
}

class App extends StatelessWidget {
  final DatabaseOperation databaseOperation;

  App({Key key, this.databaseOperation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationUnintialized) {
            return Splash();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(
              databaseOperation: databaseOperation,
            );
          }
          if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }

          return LoginPage();
        },
      ),
    );
  }
}
