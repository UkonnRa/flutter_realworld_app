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
    group("articles", () {
      test("getAll", () async {
        try {
          final articles = await Api.getInstance()
            .then((api) => api.articleListGet());
          print(articles);
        } catch (e) {
          print(e);
        }
      });

      test("get by tag", () async {
        try {
          final articles = await Api.getInstance()
            .then((api) => api.articleListGet(tag: "AngularJS"));
          print(articles);
        } catch (e) {
          print(e);
        }
      });

      test("get tags", () async {
        final tags = await Api.getInstance()
          .then((api) => api.tagGet());
        print(tags);
        print(tags.runtimeType);
      });
    });

    group("user", () {
      final username = "username_realworld";
      final email = "realworld@casterkkk.com";
      final password = "password";
      SharedPreferences.setMockInitialValues({});

      test('register', () async {
        try {
          final authUser = await Api.getInstance()
            .then((api) => api.authRegister(username, email, password));
          print("test ===> $authUser");
        } catch (e) {
          print("\ntest ===> $e");
        }
      });

      test("login", () async {
        try {
          final api = Api.getInstance();
          final authUser = await api
            .then((api) =>
            api.authLogin(email, password).then((data) {
              print("==== login ====");
              print(data);
              print("\n");
            }).then((_) {
              print("==== authCurrent ====");
              return api.authCurrent();
            }));
          print(authUser);
        } catch (e) {
          print(e);
        }
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
