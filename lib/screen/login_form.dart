import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/bloc/login_bloc.dart';
import 'package:login/bloc/login_state.dart';
import 'package:login/bloc/login_event.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        phone: _phoneController.text,
        password: _passwordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
              child: Column(children: <Widget>[
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  controller: _phoneController,
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                  controller: _passwordController,
                )),
            Padding(
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (state is LoginLoading) {
                      _onLoginButtonPressed();
                    }
                  },
                  child: Text("Login"),
                )),
          ]));
        },
      ),
    );
  }
}
