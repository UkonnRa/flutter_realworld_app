// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<Profile> _$profileSerializer = new _$ProfileSerializer();

class _$ProfileSerializer implements StructuredSerializer<Profile> {
  @override
  final Iterable<Type> types = const [Profile, _$Profile];
  @override
  final String wireName = 'Profile';

  @override
  Iterable serialize(Serializers serializers, Profile object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
      'image',
      serializers.serialize(object.image,
          specifiedType: const FullType(String)),
      'following',
      serializers.serialize(object.following,
          specifiedType: const FullType(bool)),
    ];
    if (object.bio != null) {
      result
        ..add('bio')
        ..add(serializers.serialize(object.bio,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  Profile deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ProfileBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'username':
          result.username = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bio':
          result.bio = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'image':
          result.image = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'following':
          result.following = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$Profile extends Profile {
  @override
  final String username;
  @override
  final String bio;
  @override
  final String image;
  @override
  final bool following;

  factory _$Profile([void updates(ProfileBuilder b)]) =>
      (new ProfileBuilder()..update(updates)).build();

  _$Profile._({this.username, this.bio, this.image, this.following})
      : super._() {
    if (username == null) {
      throw new BuiltValueNullFieldError('Profile', 'username');
    }
    if (image == null) {
      throw new BuiltValueNullFieldError('Profile', 'image');
    }
    if (following == null) {
      throw new BuiltValueNullFieldError('Profile', 'following');
    }
  }

  @override
  Profile rebuild(void updates(ProfileBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ProfileBuilder toBuilder() => new ProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Profile &&
        username == other.username &&
        bio == other.bio &&
        image == other.image &&
        following == other.following;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, username.hashCode), bio.hashCode), image.hashCode),
        following.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Profile')
          ..add('username', username)
          ..add('bio', bio)
          ..add('image', image)
          ..add('following', following))
        .toString();
  }
}

class ProfileBuilder implements Builder<Profile, ProfileBuilder> {
  _$Profile _$v;

  String _username;

  String get username => _$this._username;

  set username(String username) => _$this._username = username;

  String _bio;

  String get bio => _$this._bio;

  set bio(String bio) => _$this._bio = bio;

  String _image;

  String get image => _$this._image;

  set image(String image) => _$this._image = image;

  bool _following;

  bool get following => _$this._following;

  set following(bool following) => _$this._following = following;

  ProfileBuilder();

  ProfileBuilder get _$this {
    if (_$v != null) {
      _username = _$v.username;
      _bio = _$v.bio;
      _image = _$v.image;
      _following = _$v.following;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Profile other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Profile;
  }

  @override
  void update(void updates(ProfileBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Profile build() {
    final _$result = _$v ??
        new _$Profile._(
            username: username, bio: bio, image: image, following: following);
    replace(_$result);
    return _$result;
  }
}
