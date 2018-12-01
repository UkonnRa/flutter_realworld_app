// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

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

Serializer<TagList> _$tagListSerializer = new _$TagListSerializer();
Serializer<Article> _$articleSerializer = new _$ArticleSerializer();
Serializer<ArticleList> _$articleListSerializer = new _$ArticleListSerializer();

class _$TagListSerializer implements StructuredSerializer<TagList> {
  @override
  final Iterable<Type> types = const [TagList, _$TagList];
  @override
  final String wireName = 'TagList';

  @override
  Iterable serialize(Serializers serializers, TagList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'tags',
      serializers.serialize(object.tags,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(String)])),
    ];

    return result;
  }

  @override
  TagList deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TagListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'tags':
          result.tags.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltSet, const [const FullType(String)]))
              as BuiltSet);
          break;
      }
    }

    return result.build();
  }
}

class _$ArticleSerializer implements StructuredSerializer<Article> {
  @override
  final Iterable<Type> types = const [Article, _$Article];
  @override
  final String wireName = 'Article';

  @override
  Iterable serialize(Serializers serializers, Article object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'slug',
      serializers.serialize(object.slug, specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'tagList',
      serializers.serialize(object.tagList,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(String)])),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(DateTime)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(DateTime)),
      'favorited',
      serializers.serialize(object.favorited,
          specifiedType: const FullType(bool)),
      'favoritesCount',
      serializers.serialize(object.favoritesCount,
          specifiedType: const FullType(int)),
      'author',
      serializers.serialize(object.author,
          specifiedType: const FullType(Profile)),
    ];

    return result;
  }

  @override
  Article deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ArticleBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'slug':
          result.slug = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'body':
          result.body = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'tagList':
          result.tagList.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltSet, const [const FullType(String)]))
              as BuiltSet);
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'favorited':
          result.favorited = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'favoritesCount':
          result.favoritesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
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

class _$ArticleListSerializer implements StructuredSerializer<ArticleList> {
  @override
  final Iterable<Type> types = const [ArticleList, _$ArticleList];
  @override
  final String wireName = 'ArticleList';

  @override
  Iterable serialize(Serializers serializers, ArticleList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'articles',
      serializers.serialize(object.articles,
          specifiedType:
              const FullType(BuiltSet, const [const FullType(Article)])),
      'articlesCount',
      serializers.serialize(object.articlesCount,
          specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  ArticleList deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ArticleListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'articles':
          result.articles.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltSet, const [const FullType(Article)]))
              as BuiltSet);
          break;
        case 'articlesCount':
          result.articlesCount = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$TagList extends TagList {
  @override
  final BuiltSet<String> tags;

  factory _$TagList([void updates(TagListBuilder b)]) =>
      (new TagListBuilder()..update(updates)).build();

  _$TagList._({this.tags}) : super._() {
    if (tags == null) {
      throw new BuiltValueNullFieldError('TagList', 'tags');
    }
  }

  @override
  TagList rebuild(void updates(TagListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  TagListBuilder toBuilder() => new TagListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TagList && tags == other.tags;
  }

  @override
  int get hashCode {
    return $jf($jc(0, tags.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TagList')..add('tags', tags))
        .toString();
  }
}

class TagListBuilder implements Builder<TagList, TagListBuilder> {
  _$TagList _$v;

  SetBuilder<String> _tags;
  SetBuilder<String> get tags => _$this._tags ??= new SetBuilder<String>();
  set tags(SetBuilder<String> tags) => _$this._tags = tags;

  TagListBuilder();

  TagListBuilder get _$this {
    if (_$v != null) {
      _tags = _$v.tags?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TagList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TagList;
  }

  @override
  void update(void updates(TagListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$TagList build() {
    _$TagList _$result;
    try {
      _$result = _$v ?? new _$TagList._(tags: tags.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tags';
        tags.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TagList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$Article extends Article {
  @override
  final String slug;
  @override
  final String title;
  @override
  final String description;
  @override
  final String body;
  @override
  final BuiltSet<String> tagList;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final bool favorited;
  @override
  final int favoritesCount;
  @override
  final Profile author;

  factory _$Article([void updates(ArticleBuilder b)]) =>
      (new ArticleBuilder()..update(updates)).build();

  _$Article._(
      {this.slug,
      this.title,
      this.description,
      this.body,
      this.tagList,
      this.createdAt,
      this.updatedAt,
      this.favorited,
      this.favoritesCount,
      this.author})
      : super._() {
    if (slug == null) {
      throw new BuiltValueNullFieldError('Article', 'slug');
    }
    if (title == null) {
      throw new BuiltValueNullFieldError('Article', 'title');
    }
    if (description == null) {
      throw new BuiltValueNullFieldError('Article', 'description');
    }
    if (body == null) {
      throw new BuiltValueNullFieldError('Article', 'body');
    }
    if (tagList == null) {
      throw new BuiltValueNullFieldError('Article', 'tagList');
    }
    if (createdAt == null) {
      throw new BuiltValueNullFieldError('Article', 'createdAt');
    }
    if (updatedAt == null) {
      throw new BuiltValueNullFieldError('Article', 'updatedAt');
    }
    if (favorited == null) {
      throw new BuiltValueNullFieldError('Article', 'favorited');
    }
    if (favoritesCount == null) {
      throw new BuiltValueNullFieldError('Article', 'favoritesCount');
    }
    if (author == null) {
      throw new BuiltValueNullFieldError('Article', 'author');
    }
  }

  @override
  Article rebuild(void updates(ArticleBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ArticleBuilder toBuilder() => new ArticleBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Article &&
        slug == other.slug &&
        title == other.title &&
        description == other.description &&
        body == other.body &&
        tagList == other.tagList &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        favorited == other.favorited &&
        favoritesCount == other.favoritesCount &&
        author == other.author;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc($jc($jc(0, slug.hashCode), title.hashCode),
                                    description.hashCode),
                                body.hashCode),
                            tagList.hashCode),
                        createdAt.hashCode),
                    updatedAt.hashCode),
                favorited.hashCode),
            favoritesCount.hashCode),
        author.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('Article')
          ..add('slug', slug)
          ..add('title', title)
          ..add('description', description)
          ..add('body', body)
          ..add('tagList', tagList)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('favorited', favorited)
          ..add('favoritesCount', favoritesCount)
          ..add('author', author))
        .toString();
  }
}

class ArticleBuilder implements Builder<Article, ArticleBuilder> {
  _$Article _$v;

  String _slug;
  String get slug => _$this._slug;
  set slug(String slug) => _$this._slug = slug;

  String _title;
  String get title => _$this._title;
  set title(String title) => _$this._title = title;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _body;
  String get body => _$this._body;
  set body(String body) => _$this._body = body;

  SetBuilder<String> _tagList;
  SetBuilder<String> get tagList =>
      _$this._tagList ??= new SetBuilder<String>();
  set tagList(SetBuilder<String> tagList) => _$this._tagList = tagList;

  DateTime _createdAt;
  DateTime get createdAt => _$this._createdAt;
  set createdAt(DateTime createdAt) => _$this._createdAt = createdAt;

  DateTime _updatedAt;
  DateTime get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime updatedAt) => _$this._updatedAt = updatedAt;

  bool _favorited;
  bool get favorited => _$this._favorited;
  set favorited(bool favorited) => _$this._favorited = favorited;

  int _favoritesCount;
  int get favoritesCount => _$this._favoritesCount;
  set favoritesCount(int favoritesCount) =>
      _$this._favoritesCount = favoritesCount;

  ProfileBuilder _author;
  ProfileBuilder get author => _$this._author ??= new ProfileBuilder();
  set author(ProfileBuilder author) => _$this._author = author;

  ArticleBuilder();

  ArticleBuilder get _$this {
    if (_$v != null) {
      _slug = _$v.slug;
      _title = _$v.title;
      _description = _$v.description;
      _body = _$v.body;
      _tagList = _$v.tagList?.toBuilder();
      _createdAt = _$v.createdAt;
      _updatedAt = _$v.updatedAt;
      _favorited = _$v.favorited;
      _favoritesCount = _$v.favoritesCount;
      _author = _$v.author?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Article other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$Article;
  }

  @override
  void update(void updates(ArticleBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$Article build() {
    _$Article _$result;
    try {
      _$result = _$v ??
          new _$Article._(
              slug: slug,
              title: title,
              description: description,
              body: body,
              tagList: tagList.build(),
              createdAt: createdAt,
              updatedAt: updatedAt,
              favorited: favorited,
              favoritesCount: favoritesCount,
              author: author.build());
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'tagList';
        tagList.build();

        _$failedField = 'author';
        author.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'Article', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$ArticleList extends ArticleList {
  @override
  final BuiltSet<Article> articles;
  @override
  final int articlesCount;

  factory _$ArticleList([void updates(ArticleListBuilder b)]) =>
      (new ArticleListBuilder()..update(updates)).build();

  _$ArticleList._({this.articles, this.articlesCount}) : super._() {
    if (articles == null) {
      throw new BuiltValueNullFieldError('ArticleList', 'articles');
    }
    if (articlesCount == null) {
      throw new BuiltValueNullFieldError('ArticleList', 'articlesCount');
    }
  }

  @override
  ArticleList rebuild(void updates(ArticleListBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  ArticleListBuilder toBuilder() => new ArticleListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ArticleList &&
        articles == other.articles &&
        articlesCount == other.articlesCount;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, articles.hashCode), articlesCount.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ArticleList')
          ..add('articles', articles)
          ..add('articlesCount', articlesCount))
        .toString();
  }
}

class ArticleListBuilder implements Builder<ArticleList, ArticleListBuilder> {
  _$ArticleList _$v;

  SetBuilder<Article> _articles;
  SetBuilder<Article> get articles =>
      _$this._articles ??= new SetBuilder<Article>();
  set articles(SetBuilder<Article> articles) => _$this._articles = articles;

  int _articlesCount;
  int get articlesCount => _$this._articlesCount;
  set articlesCount(int articlesCount) => _$this._articlesCount = articlesCount;

  ArticleListBuilder();

  ArticleListBuilder get _$this {
    if (_$v != null) {
      _articles = _$v.articles?.toBuilder();
      _articlesCount = _$v.articlesCount;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ArticleList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$ArticleList;
  }

  @override
  void update(void updates(ArticleListBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$ArticleList build() {
    _$ArticleList _$result;
    try {
      _$result = _$v ??
          new _$ArticleList._(
              articles: articles.build(), articlesCount: articlesCount);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'articles';
        articles.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ArticleList', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}
