import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:intl/intl.dart';

final dateFormatter = DateFormat('yyyy-mm-dd HH:MM:ss');

void errorHandle(Error e, BuildContext context) {
  if (e is DioError) {
    String message;
    switch (e.response.statusCode) {
      case 401:
        message = S.of(context).error401;
        break;
      case 403:
        message = S.of(context).error403;
        break;
      case 404:
        message = S.of(context).error404;
        break;
      case 422:
        final errors = e.response.data["errors"] as Map<String, dynamic>;
        message = errors.entries
            .map((e) => "${e.key}: ${e.value}")
            .reduce((s1, s2) => "$s1\n$s2");
        break;
      default:
        message = S.of(context).errorUnknown(e.toString());
        break;
    }
    Flushbar()
      ..message = message
      ..duration = Duration(seconds: 5)
      ..show(context);
  } else {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: Text(S.of(context).error),
            content: Text(S.of(context).errorUnknown(e.toString())),
          ),
    );
  }
}

void startLoading(BuildContext context) =>
    showGeneralDialog<CircularProgressIndicator>(
      context: context,
      barrierDismissible: false,
      barrierLabel: "Loading...",
      barrierColor: Colors.black38,
      transitionDuration: Duration(seconds: 1),
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          WillPopScope(
              child: Center(
                child: CircularProgressIndicator(),
              ),
              onWillPop: () async => false),
    );

void finishLoading(BuildContext context) => Navigator.of(context).pop();

bool isNullEmpty(String s, {bool trim = false}) =>
    s == null || s == "" || (trim ? isNullEmpty(s.trim()) : false);

void showInfoDialog(BuildContext context, {String title, String content}) =>
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: title == null ? null : Text(title),
            content: content == null ? null : Text(content),
            actions: <Widget>[
              FlatButton(
                child: Text(S.of(context).ok),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
    );

void showAbout(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => AlertDialog(
            title: Text(S.of(context).aboutApp),
            actions: <Widget>[
              FlatButton(
                child: Text(S.of(context).ok),
                onPressed: () => Navigator.pop(context),
              )
            ],
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    S.of(context).aboutInfo,
                    style: Theme.of(context).textTheme.body2,
                  ),
                ],
              ),
            ),
          ),
    );
