import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_realworld_app/models/serializers.dart';
import 'package:validators/validators.dart' as v;

part 'user.g.dart';

abstract class AuthUser implements Built<AuthUser, AuthUserBuilder> {
  static Serializer<AuthUser> get serializer => _$authUserSerializer;

  String get email;

  String get token;

  String get username;

  @nullable
  String get bio;

  @nullable
  String get image;

  factory AuthUser([updates(AuthUserBuilder b)]) = _$AuthUser;

  AuthUser._() {
    v.isEmail(email);
  }

  static AuthUser fromRequest(Map<String, dynamic> requestData) =>
      serializers.deserializeWith(AuthUser.serializer, requestData["user"]);
}
