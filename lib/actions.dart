import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuple/tuple.dart';

/// DO NOT CHANGE [AppState] to [AuthUser] AGAIN!!!
/// ReduRx cannot deal with Store(null) correctly!!!

typedef void CallbackFunction();
typedef void ErrorHandlerFunction(Error err);
typedef Future<Tuple2<AuthUser, Profile>> ReduceBodyFunction();

abstract class AbstractAsyncAction extends AsyncAction<AppState> {
  final CallbackFunction _successCallback;
  final ErrorHandlerFunction _errorHandler;
  final Future<Api> _api = Api.getInstance();

  AbstractAsyncAction(this._successCallback, this._errorHandler);

  Future<Computation<AppState>> _reduce(ReduceBodyFunction func) async {
    try {
      final tuple = await func.call();
      _successCallback?.call();
      return (AppState _) => _.rebuild((b) => b
        ..currentUser = tuple.item1?.toBuilder()
        ..currentProfile = tuple.item2?.toBuilder());
    } catch (e) {
      _errorHandler?.call(e);
      return Future.value((AppState _) => _);
    }
  }
}

class AuthLogin extends AbstractAsyncAction {
  final String _email, _password;

  AuthLogin(this._email, this._password,
      {CallbackFunction successCallback, ErrorHandlerFunction errorHandler})
      : super(successCallback, errorHandler);

  @override
  Future<Computation<AppState>> reduce(AppState state) async => _reduce(
        () => _api.then(
              (api) async {
                final user = await api.authLogin(_email, _password);
                final profile = await api.profileGet(user.username);
                return Tuple2(user, profile);
              },
            ),
      );
}

class AuthCurrent extends AbstractAsyncAction {
  AuthCurrent(
      {CallbackFunction successCallback, ErrorHandlerFunction errorHandler})
      : super(successCallback, errorHandler);

  @override
  Future<Computation<AppState>> reduce(AppState state) async => _reduce(
        () => _api.then(
              (api) async {
                final user = await api.authCurrent();
                final profile = await api.profileGet(user.username);
                return Tuple2(user, profile);
              },
            ),
      );
}

class AuthUpdate extends AbstractAsyncAction {
  final String _email, _bio, _image, _username, _password;

  AuthUpdate(
      {String email,
      String bio,
      String image,
      String username,
      String password,
      CallbackFunction successCallback,
      ErrorHandlerFunction errorHandler})
      : this._email = email,
        this._bio = bio,
        this._image = image,
        this._username = username,
        this._password = password,
        super(successCallback, errorHandler);

  @override
  Future<Computation<AppState>> reduce(AppState state) async => _reduce(
        () => _api.then(
              (api) async {
                final user = await api.authUpdate(
                    email: _email,
                    bio: _bio,
                    image: _image,
                    username: _username,
                    password: _password);
                final profile = await api.profileGet(user.username);
                return Tuple2(user, profile);
              },
            ),
      );
}

class Logout extends AbstractAsyncAction {
  Logout({CallbackFunction successCallback, ErrorHandlerFunction errorHandler})
      : super(successCallback, errorHandler);

  @override
  Future<Computation<AppState>> reduce(AppState state) =>
      _reduce(() => SharedPreferences.getInstance().then((pref) {
            pref.remove("jwt");
            return Tuple2(null, null);
          }));
}
