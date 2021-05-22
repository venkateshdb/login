import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:login/database/database_operation.dart';
import 'package:login/bloc/authentication_bloc.dart';
import 'package:login/bloc/login_bloc.dart';
import 'package:login/screen/login_form.dart';

class LoginPage extends StatelessWidget {
  final DatabaseOperation databaseOperation;

  LoginPage({Key key, this.databaseOperation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocProvider(
        create: (context) {
          return LoginBloc(
            authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
            databaseOperation: databaseOperation,
          );
        },
        child: LoginForm(),
      ),
    );
  }
}
