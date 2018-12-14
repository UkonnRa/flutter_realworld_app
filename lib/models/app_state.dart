import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_realworld_app/models/user.dart';

part 'app_state.g.dart';

abstract class AppState implements Built<AppState, AppStateBuilder> {
  static Serializer<AppState> get serializer => _$appStateSerializer;

  @nullable
  AuthUser get currentUser;

  factory AppState([updates(AppStateBuilder b)]) = _$AppState;

  AppState._();
}
