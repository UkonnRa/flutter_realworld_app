import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_realworld_app/models/serializers.dart';

part 'profile.g.dart';

abstract class Profile implements Built<Profile, ProfileBuilder> {
  static Serializer<Profile> get serializer => _$profileSerializer;

  String get username;
  @nullable
  String get bio;
  String get image;
  bool get following;

  factory Profile([updates(ProfileBuilder b)]) = _$Profile;
  Profile._();

  static Profile fromRequest(Map<String, dynamic> requestData) =>
    serializers.deserializeWith(Profile.serializer, requestData["profile"]);

}
