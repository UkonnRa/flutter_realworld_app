// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

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

Serializer<Comment> _$commentSerializer = new _$CommentSerializer();
Serializer<CommentList> _$commentListSerializer = new _$CommentListSerializer();

class _$CommentSerializer implements StructuredSerializer<Comment> {
  @override
  final Iterable<Type> types = const [Comment, _$Comment];
  @override
  final String wireName = 'Comment';

  @override
  Iterable serialize(Serializers serializers, Comment object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(int)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(DateTime)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(Profile)),
    ];

    return result;
  }

  @override
  Comment deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'author':
          result.author.replace(serializers.deserialize(value,
              specifiedType: const FullType(Profile)) as Profile);
          break;
      }
    }

    return result.build();
  }
}

class _$CommentListSerializer implements StructuredSerializer<CommentList> {
  @override
  final Iterable<Type> types = const [CommentList, _$CommentList];
  @override
  final String wireName = 'CommentList';

  @override
  Iterable serialize(Serializers serializers, CommentList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'comments',
      serializers.serialize(object.comments,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(Comment)])),
    ];

    return result;
  }

  @override
  CommentList deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new CommentListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'comments':
          result.comments.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltSet, const [const FullType(Comment)]))
              as BuiltSet);
          break;
      }
    }

    return result.build();
  }
}

class _$Comment extends Comment {
  @override
  final int id;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String body;
  @override
  final Profile author;

  factory _$Comment([void updates(CommentBuilder b)]) =>
      (new CommentBuilder()..update(updates)).build();

  _$Comment._({this.id, this.createdAt, this.updatedAt, this.body, this.author})
      : super._() {
    if (id == null) {
      throw new BuiltValueNullFieldError('Comment', 'id');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('Comment', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('Comment', 'updatedAt');
    }
    if (body == null) {
      throw new BuiltValueNullFieldError('Comment', 'body');
    }
    if (author == null) {
      throw new BuiltValueNullFieldError('Comment', 'author');
    }
  }

  @override
  Comment rebuild(void updates(CommentBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentBuilder toBuilder() => new CommentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Comment &&
        id == other.id &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        body == other.body &&
        author == other.author;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc($jc($jc(0, id.hashCode), createdAt.hashCode),
                updatedAt.hashCode),
            body.hashCode),
        author.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Comment')
          ..add('id', id)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('body', body)
          ..add('author', author))
        .toString();
  }
}

class CommentBuilder implements Builder<Comment, CommentBuilder> {
  _$Comment _$v;

  int _id;
  int get id => _$this._id;
  set id(int id) => _$this._id = id;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  String _body;
  String get body => _$this._body;
  set body(String body) => _$this._body = body;

  ProfileBuilder _author;
  ProfileBuilder get author => _$this._author ??= new ProfileBuilder();
  set author(ProfileBuilder author) => _$this._author = author;

  CommentBuilder();

  CommentBuilder get _$this {
    if (_$v != null) {
      _id = _$v.id;
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _body = _$v.body;
      _author = _$v.author?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Comment other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Comment;
  }

  @override
  void update(void updates(CommentBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Comment build() {
    _$Comment _$result;
    try {
      _$result = _$v ??
          new _$Comment._(
              id: id,
              createdAt: createdAt,
              updatedAt: updatedAt,
              body: body,
              author: author.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'author';
        author.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Comment', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$CommentList extends CommentList {
  @override
  final BuiltSet<Comment> comments;

  factory _$CommentList([void updates(CommentListBuilder b)]) =>
      (new CommentListBuilder()..update(updates)).build();

  _$CommentList._({this.comments}) : super._() {
    if (comments == null) {
      throw new BuiltValueNullFieldError('CommentList', 'comments');
    }
  }

  @override
  CommentList rebuild(void updates(CommentListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  CommentListBuilder toBuilder() => new CommentListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommentList && comments == other.comments;
  }

  @override
  int get hashCode {
    return $jf($jc(0, comments.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('CommentList')
          ..add('comments', comments))
        .toString();
  }
}

class CommentListBuilder implements Builder<CommentList, CommentListBuilder> {
  _$CommentList _$v;

  SetBuilder<Comment> _comments;
  SetBuilder<Comment> get comments =>
      _$this._comments ??= new SetBuilder<Comment>();
  set comments(SetBuilder<Comment> comments) => _$this._comments = comments;

  CommentListBuilder();

  CommentListBuilder get _$this {
    if (_$v != null) {
      _comments = _$v.comments?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommentList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$CommentList;
  }

  @override
  void update(void updates(CommentListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$CommentList build() {
    _$CommentList _$result;
    try {
      _$result = _$v ?? new _$CommentList._(comments: comments.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'comments';
        comments.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'CommentList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
