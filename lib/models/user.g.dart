// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

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

Serializer<AuthUser> _$authUserSerializer = new _$AuthUserSerializer();

class _$AuthUserSerializer implements StructuredSerializer<AuthUser> {
  @override
  final Iterable<Type> types = const [AuthUser, _$AuthUser];
  @override
  final String wireName = 'AuthUser';

  @override
  Iterable serialize(Serializers serializers, AuthUser object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'email',
      serializers.serialize(object.email,
          specifiedType: const FullType(String)),
      'token',
      serializers.serialize(object.token,
          specifiedType: const FullType(String)),
      'username',
      serializers.serialize(object.username,
          specifiedType: const FullType(String)),
    ];
    if (object.bio != null) {
      result
        ..add('bio')
        ..add(serializers.serialize(object.bio,
            specifiedType: const FullType(String)));
    }
    if (object.image != null) {
      result
        ..add('image')
        ..add(serializers.serialize(object.image,
            specifiedType: const FullType(String)));
    }

    return result;
  }

  @override
  AuthUser deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new AuthUserBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'email':
          result.email = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'token':
          result.token = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
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
      }
    }

    return result.build();
  }
}

class _$AuthUser extends AuthUser {
  @override
  final String email;
  @override
  final String token;
  @override
  final String username;
  @override
  final String bio;
  @override
  final String image;

  factory _$AuthUser([void updates(AuthUserBuilder b)]) =>
      (new AuthUserBuilder()..update(updates)).build();

  _$AuthUser._({this.email, this.token, this.username, this.bio, this.image})
      : super._() {
    if (email == null) {
      throw new BuiltValueNullFieldError('AuthUser', 'email');
    }
    if (token == null) {
      throw new BuiltValueNullFieldError('AuthUser', 'token');
    }
    if (username == null) {
      throw new BuiltValueNullFieldError('AuthUser', 'username');
    }
  }

  @override
  AuthUser rebuild(void updates(AuthUserBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthUserBuilder toBuilder() => new AuthUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthUser &&
        email == other.email &&
        token == other.token &&
        username == other.username &&
        bio == other.bio &&
        image == other.image;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, email.hashCode), token.hashCode), username.hashCode),
            bio.hashCode),
        image.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AuthUser')
          ..add('email', email)
          ..add('token', token)
          ..add('username', username)
          ..add('bio', bio)
          ..add('image', image))
        .toString();
  }
}

class AuthUserBuilder implements Builder<AuthUser, AuthUserBuilder> {
  _$AuthUser _$v;

  String _email;

  String get email => _$this._email;

  set email(String email) => _$this._email = email;

  String _token;

  String get token => _$this._token;

  set token(String token) => _$this._token = token;

  String _username;

  String get username => _$this._username;

  set username(String username) => _$this._username = username;

  String _bio;

  String get bio => _$this._bio;

  set bio(String bio) => _$this._bio = bio;

  String _image;

  String get image => _$this._image;

  set image(String image) => _$this._image = image;

  AuthUserBuilder();

  AuthUserBuilder get _$this {
    if (_$v != null) {
      _email = _$v.email;
      _token = _$v.token;
      _username = _$v.username;
      _bio = _$v.bio;
      _image = _$v.image;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthUser other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$AuthUser;
  }

  @override
  void update(void updates(AuthUserBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AuthUser build() {
    final _$result = _$v ??
        new _$AuthUser._(
            email: email,
            token: token,
            username: username,
            bio: bio,
            image: image);
    replace(_$result);
    return _$result;
  }
}
