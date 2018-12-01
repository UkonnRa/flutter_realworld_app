import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_realworld_app/pages/main_page.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  final user = Profile((b) => b
    ..bio = "bio1"
    ..image = "img1"
    ..username = "user1"
  ..following = false);
  final article = Article((b) => b
  ..slug = "slug1"
  ..title = "title1"
  ..description = "desc1"
  ..body = "body1"
  ..tagList = SetBuilder(["tag1", "tag2", "tag2"])
    ..createdAt = DateTime.utc(2018, 1, 1, 0, 0, 0, 0)
    ..updatedAt = DateTime.utc(2019, 1, 1, 0, 0, 0, 0)
    ..favorited = false
    ..favoritesCount = 10
    ..author = user.toBuilder()
  );
  final store = Store<Article>(article);

  runApp(Provider(store: store, child: RealworldApp()));
}

class RealworldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.lightGreen, accentColor: Colors.orange),
      home: MainPage(),
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}
