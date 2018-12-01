import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/redux/actions/actions.dart';
import 'package:flutter_realworld_app/models/serializers.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_redurx/flutter_redurx.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).mainPageTitle),
      ),
      body: Center(
        child: Connect<Article, String>(
          convert: (state) => json.encode(serializers.serialize(state)),
          where: (oldState, newState) => oldState != newState,
          builder: (state) => Text(state),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Provider.dispatch<Article>(context, ChangeEmail()),
        tooltip: 'ChangeEmail',
        child: Icon(Icons.add),
      ));
}
