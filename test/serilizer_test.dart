import "dart:convert";

import "package:built_collection/built_collection.dart";
import 'package:flutter_realworld_app/api.dart';
import "package:flutter_realworld_app/models/article.dart";
import "package:flutter_realworld_app/models/profile.dart";
import "package:flutter_realworld_app/models/serializers.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "package:test/test.dart";

void main() {
  group("api", () {
    const API_HEADER = 'https://conduit.productionready.io/api';
    group("articles", () {
      test("getAll", () async {
        Api.getInstance(API_HEADER)
            .flatMap((api) => api.articleListGet())
            .listen(print, onError: print);
        await Future.delayed(Duration(seconds: 5));
      });

      test("get by tag", () async {
        Api.getInstance(API_HEADER)
        .flatMap((api) => api.articleListGet(tag: "AngularJS"))
          .listen(print, onError: print);
        await Future.delayed(Duration(seconds: 5));
      });
    });

    group("user", () {
      final username = "username_realworld";
      final email = "realworld@casterkkk.com";
      final password = "password";
      SharedPreferences.setMockInitialValues({});

      test('register', () async {
        Api.getInstance(API_HEADER)
            .flatMap((api) => api.authRegister(username, email, password))
            .listen(print, onError: print);
        await Future.delayed(Duration(seconds: 5));
      });

      test("login", () async {
        final api = Api.getInstance('https://conduit.productionready.io/api');
        api
            .flatMap((api) => api.authLogin(email, password).map((data) {
                  print("==== login ====");
                  print(data);
                  print("\n");
                }).flatMap((_) {
                  print("==== authCurrent ====");
                  return api.authCurrent();
                }))
            .listen(print, onError: print);
        await Future.delayed(Duration(seconds: 5));
      });
    });
  });

  group("ser_des", () {
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
      ..author = user.toBuilder());

    test("ser", () {
      print(article);
      final res = serializers.serialize(article);
      print(json.encode(res));
    });

    test("des", () {
      const jsonStr = """
      {
            "slug": "slug1",
            "title": "title1",
            "description": "desc1",
            "body": "body1",
            "tagList": ["tag1", "tag2"],
            "createdAt": "2016-02-18T03:22:56.637Z",
            "updatedAt": "2016-02-18T03:22:56.637Z",
            "favorited": false,
            "favoritesCount": 10,
            "author": {"username": "user1", "bio": "bio1", "image": "img1", "following": false}
          }
      """;
      final art =
          serializers.deserializeWith(Article.serializer, json.decode(jsonStr));
      print(art);
      expect(art.createdAt.year, 2016);
    });
  });
}
