import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/util.dart' as util;
import 'package:validators/validators.dart' as v;

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _email, _password, _username;
  final _passwordKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    final logo = Container(
      alignment: Alignment.center,
      child: Text(
        "conduit",
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w900, fontSize: 48),
      ),
    );

    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          hintText: S.of(context).email,
          hintStyle: TextStyle(color: Colors.black45),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white),
      validator: (value) {
        if (!v.isEmail(value)) {
          return S.of(context).validatorNotEmail;
        }
      },
      onSaved: (value) {
        _email = value;
      },
    );

    final username = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          hintText: S.of(context).username,
          hintStyle: TextStyle(color: Colors.black45),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white),
      validator: (value) {
        if (util.isNullEmpty(value)) {
          return S.of(context).validatorNotEmpty;
        }
      },
      onSaved: (value) {
        _username = value;
      },
    );

    final password = TextFormField(
        key: _passwordKey,
        autofocus: false,
        obscureText: true,
        decoration: InputDecoration(
            hintText: S.of(context).password,
            hintStyle: TextStyle(color: Colors.black45),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32.0),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: Colors.white),
        validator: (value) {
          if (value.length < 6) return S.of(context).validatorTooShortPassword;
        },
        onSaved: (value) {
          _password = value;
        });

    final repassword = TextFormField(
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          hintText: S.of(context).repassword,
          hintStyle: TextStyle(color: Colors.black45),
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.white),
      validator: (value) {
        if (_passwordKey.currentState.value != value) {
          return S.of(context).validatorNotSamePassword;
        }
      },
    );

    final submitButton = RaisedButton(
      color: Theme.of(context).accentColor,
      child: Text(S.of(context).submit),
      onPressed: () async {
        _formKey.currentState.save();
        if (_formKey.currentState.validate()) {
          try {
            util.startLoading(context);
            final api = await Api.getInstance();
            await api.authRegister(_username, _email, _password);
            util.finishLoading(context);
            Navigator.pop(context);
            util.flushbar(context, S.of(context).registerSuccessfulTitle,
                S.of(context).registerSuccessful);
          } catch (e) {
            util.finishLoading(context);
            util.errorHandle(e, context);
          }
        }
      },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 48.0),
                child: logo,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: email,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: username,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: password,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: repassword,
              ),
              submitButton,
            ],
          ),
        ),
      ),
    );
  }
}
