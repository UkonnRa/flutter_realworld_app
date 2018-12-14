import 'package:dio/dio.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/comment.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_realworld_app/util.dart' as util;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  Dio _dio;
  static final Map<String, Api> _cache = Map();

  Api._internal(this._dio);

  static Future<Api> getInstance(
      {String apiRoot = 'https://conduit.productionready.io/api'}) async {
    if (!_cache.containsKey(apiRoot)) {
      final ops = Options(
          baseUrl: apiRoot,
          headers: {"Content-Type": "application/json; charset=utf-8"});
      final dio = Dio(ops);
      final prefs = await SharedPreferences.getInstance();
      dio.interceptor.request.onSend = (ops) {
        final jwt = prefs.getString('jwt');
        if (jwt != null) {
          ops.headers['Authorization'] = "Token $jwt";
        }
        return ops;
      };
      _cache[apiRoot] = Api._internal(dio);
    }
    return _cache[apiRoot];
  }

  Map<String, dynamic> _respBody(Response<dynamic> resp) =>
      resp.data as Map<String, dynamic>;

  Future<Map<String, dynamic>> _get(path, {Map<String, dynamic> data}) async {
    if (data != null) {
      data = Map.fromIterable(data.keys.where((k) => data[k] != null),
          value: (k) => data[k]);
    }
    return await _dio.get(path, data: data).then(_respBody);
  }

  Future<Map<String, dynamic>> _del(path) async =>
      await _dio.delete(path).then(_respBody);

  Future<Map<String, dynamic>> _post(path, {data}) async =>
      await _dio.post(path, data: data).then(_respBody);

  Future<Map<String, dynamic>> _put(path, {data}) async =>
      await _dio.put(path, data: data).then(_respBody);

  Future<AuthUser> authCurrent() => _get('/user').then(AuthUser.fromRequest);

  Future<AuthUser> authLogin(String email, String password) async {
    final user = await _post('/users/login', data: {
      "user": {"email": email, "password": password}
    }).then(AuthUser.fromRequest);

    final pref = await SharedPreferences.getInstance();

    pref.setString("jwt", user.token);
    return user;
  }

  Future<AuthUser> authRegister(
          String username, String email, String password) =>
      _post('/users', data: {
        "user": {"username": username, "email": email, "password": password}
      }).then(AuthUser.fromRequest);

  Future<AuthUser> authUpdate(
          {String email,
          String bio,
          String image,
          String username,
          String password}) =>
      _put('/user', data: {
        'user': {
          'email': email,
          'bio': bio,
          'image': image,
          'username': username,
          'password': util.isNullEmpty(password) ? null : password
        }
      }).then(AuthUser.fromRequest);

  Future<Profile> profileGet(String username) =>
      _get('/profiles/$username').then(Profile.fromRequest);

  Future<Profile> profileFollow(String username) =>
      _post('/profiles/$username/follow').then(Profile.fromRequest);

  Future<Profile> profileUnfollow(String username) =>
      _del('/profiles/$username/follow').then(Profile.fromRequest);

  Future<ArticleList> articleListGet(
          {String tag,
          String author,
          String favorited,
          int limit = 20,
          int offset = 0}) =>
      _get('/articles', data: {
        'tag': tag,
        'author': author,
        'favorited': favorited,
        'limit': limit,
        'offset': offset
      }).then(ArticleList.fromRequest);

  Future<ArticleList> articleListFeed({int limit = 20, int offset = 0}) =>
      _get('/articles/feed', data: {'limit': limit, 'offset': offset})
          .then(ArticleList.fromRequest);

  Future<Article> articleGet(String slug) =>
      _get('/articles/$slug').then(Article.fromRequest);

  Future<Article> articleCreate(String title, String description, String body,
          List<String> tagList) =>
      _post('/articles', data: {
        "article": {
          "title": title,
          "description": description,
          "body": body,
          "tagList": tagList
        }
      }).then(Article.fromRequest);

  Future<Article> articleUpdate(String slug, String title, String description,
          String body, List<String> tagList) =>
      _put('/articles/$slug', data: {
        "article": {
          "title": title,
          "description": description,
          "body": body,
          "tagList": tagList
        }
      }).then(Article.fromRequest);

  Future<Article> articleDelete(String slug) =>
      _del('/articles/$slug').then(Article.fromRequest);

  Future<Comment> commentAdd(String slug, String commentBody) =>
      _post('/articles/$slug}/comments', data: {
        "comment": {"body": commentBody}
      }).then(Comment.fromRequest);

  Future<CommentList> commentGet(String slug) =>
      _get('/articles/$slug/comments').then(CommentList.fromRequest);

  Future<void> commentDelete(String slug, String id) =>
      _del('/articles/$slug/comments/$id').then((_) => null);

  Future<Article> articleFavorite(String slug) =>
      _post('/articles/$slug/favorite').then(Article.fromRequest);

  Future<Article> articleUnfavorite(String slug) =>
      _del('/articles/$slug/favorite').then(Article.fromRequest);

  Future<List<String>> tagGet() =>
      _get('/tags').then((res) => List<String>.from(res['tags']));
}
