import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:dio/dio.dart';

class Login extends Action<AuthUser> {
  String _email, _password;
  Login(this._email, this._password);

  @override
  reduce(AuthUser state) async {

  }

}
