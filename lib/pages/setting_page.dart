import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/actions.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_realworld_app/util.dart' as util;
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:validators/validators.dart' as v;

class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final _formKey = GlobalKey<FormState>();

  String _avatarUrl;
  String _username;
  String _bio;
  String _email;
  String _newPassword;

  @override
  Widget build(BuildContext context) => Connect<AppState, AuthUser>(
        convert: (AppState state) => state.currentUser,
        where: (AuthUser oldState, AuthUser newState) => oldState != newState,
        builder: (AuthUser currentUser) => Scaffold(
              appBar: AppBar(
                title: Text(S.of(context).settings),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        util.startLoading(context);
                        Provider.dispatch<AppState>(
                          context,
                          AuthUpdate(
                              successCallback: () {
                                util.finishLoading(context);
                                Navigator.of(context).pop();
                                Navigator.of(context).pop();
                                Flushbar()
                                  ..title =
                                      S.of(context).settingChangeSuccessfulTitle
                                  ..message =
                                      S.of(context).settingChangeSuccessful
                                  ..duration = Duration(seconds: 5)
                                  ..show(context);
                              },
                              errorHandler: (err) {
                                util.finishLoading(context);
                                util.errorHandle(err, context);
                              },
                              email: _email,
                              bio: _bio,
                              image: _avatarUrl,
                              username: _username,
                              password: _newPassword),
                        );
                      }
                    },
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Form(
                  autovalidate: true,
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration:
                            InputDecoration(labelText: S.of(context).avatarUrl),
                        initialValue: currentUser.image,
                        validator: (value) {
                          if (util.isNullEmpty(value)) {
                            return null;
                          }
                          if (!v.isURL(value)) {
                            return S.of(context).validatorNotUrl;
                          }
                        },
                        onSaved: (value) {
                          if (util.isNullEmpty(value, trim: true))
                            _avatarUrl = null;
                          else
                            _avatarUrl = value;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          initialValue: currentUser.username,
                          decoration: InputDecoration(
                              labelText: S.of(context).username),
                          validator: (value) {
                            if (util.isNullEmpty(value, trim: true)) {
                              return S.of(context).validatorNotEmpty;
                            }
                          },
                          onSaved: (value) {
                            _username = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          initialValue: currentUser.bio,
                          decoration: InputDecoration(
                              labelText: S.of(context).biography),
                          onSaved: (value) {
                            _bio = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          initialValue: currentUser.email,
                          decoration:
                              InputDecoration(labelText: S.of(context).email),
                          validator: (value) {
                            value = value.trim();
                            if (!v.isEmail(value)) {
                              return S.of(context).validatorNotEmail;
                            }
                          },
                          onSaved: (value) {
                            _email = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: TextFormField(
                          obscureText: true,
                          validator: (value) {
                            return (value.length != 0 && value.length < 6)
                                ? S.of(context).validatorTooShortPassword
                                : null;
                          },
                          decoration: InputDecoration(
                              labelText: S.of(context).newPassword),
                          onSaved: (value) {
                            _newPassword = value;
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
      );
}
