import 'package:dio/dio.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

class Api {
  Dio _dio;
  static final Map<String, Observable<Api>> _cache = Map();

  Api._internal(this._dio);

  static Observable<Api> getInstance(String apiRoot) {
    if (!_cache.containsKey(apiRoot)) {
      final ops = Options(
          baseUrl: apiRoot,
          headers: {"Content-Type": "application/json; charset=utf-8"});
      final dio = Dio(ops);
      final obs =
          Observable.fromFuture(SharedPreferences.getInstance()).map((prefs) {
        dio.interceptor.request.onSend = (ops) {
          final jwt = prefs.getString('jwt');
          if (jwt != null) {
            ops.headers['Authorization'] = "Token $jwt";
          }
          return ops;
        };
        return Api._internal(dio);
      });
      _cache[apiRoot] = obs;
    }
    return _cache[apiRoot];
  }

  Map<String, dynamic> _respBody(Response<dynamic> resp) =>
      resp.data as Map<String, dynamic>;

  _errHandle(err) {
    if (err is DioError) {
      print("resp : ${err.response}");
      print("message : ${err.message}");
      print("type : ${err.type}");
    } else {
      print(err);
    }
  }

  Future<Map<String, dynamic>> _get(path, {Map<String, dynamic> data}) async {
    if (data != null) {
      data = Map.fromIterable(data.keys.where((k) => data[k] != null), value: (k) => data[k]);
    }
    return await _dio.get(path, data: data).then(_respBody).catchError(_errHandle);
  }

  Future<Map<String, dynamic>> _del(path) async =>
      await _dio.delete(path).then(_respBody).catchError(_errHandle);

  Future<Map<String, dynamic>> _post(path, {data}) async =>
      await _dio.post(path, data: data).then(_respBody).catchError(_errHandle);

  Future<Map<String, dynamic>> _put(path, {data}) async =>
      await _dio.put(path, data: data).then(_respBody).catchError(_errHandle);

  Observable<AuthUser> authCurrent() =>
      Observable.fromFuture(_get('/user')).map(AuthUser.fromRequest);

  Observable<AuthUser> authLogin(String email, String password) {
    final userOb = Observable.fromFuture(_post('/users/login', data: {
      "user": {"email": email, "password": password}
    })).map(AuthUser.fromRequest);

    final prefOb = Observable.fromFuture(SharedPreferences.getInstance());

    return Observable.zip2(userOb, prefOb,
            (user, pref) => Tuple2<AuthUser, SharedPreferences>(user, pref))
        .map((tuple) {
      tuple.item2.setString("jwt", tuple.item1.token);
      return tuple.item1;
    });
  }

  Observable<AuthUser> authRegister(
          String username, String email, String password) =>
      Observable.fromFuture(_post('/users', data: {
        "user": {"username": username, "email": email, "password": password}
      })).map(AuthUser.fromRequest);

  Observable<AuthUser> authUpdate(AuthUser newUser) =>
      Observable.fromFuture(_put('/user', data: {
        'user': {
          'email': newUser.email,
          'bio': newUser.bio,
          'image': newUser.image
        }
      })).map(AuthUser.fromRequest);

  Observable<Profile> profileGet(String username) =>
      Observable.fromFuture(_get('/profiles/$username'))
          .map(Profile.fromRequest);

  Observable<Profile> profileFollow(String username) =>
      Observable.fromFuture(_post('/profiles/$username/follow'))
          .map(Profile.fromRequest);

  Observable<Profile> profileUnfollow(String username) =>
      Observable.fromFuture(_del('/profiles/$username/follow'))
          .map(Profile.fromRequest);

  Observable<ArticleList> articleListGet(
          {String tag,
          String author,
          String favorited,
          int limit = 20,
          int offset = 0}) =>
      Observable.fromFuture(_get('/articles', data: {
        'tag': tag,
        'author': author,
        'favorited': favorited,
        'limit': limit,
        'offset': offset
      })).map(ArticleList.fromRequest);
}
