import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/serializers.dart';

part 'article.g.dart';

abstract class TagList implements Built<TagList, TagListBuilder> {
  static Serializer<TagList> get serializer => _$tagListSerializer;

  BuiltSet<String> get tags;

  factory TagList([updates(TagListBuilder b)]) = _$TagList;

  TagList._();
}

abstract class Article implements Built<Article, ArticleBuilder> {
  static Serializer<Article> get serializer => _$articleSerializer;

  String get slug;

  String get title;

  String get description;

  String get body;

  BuiltSet<String> get tagList;

  DateTime get createdAt;

  DateTime get updatedAt;

  bool get favorited;

  int get favoritesCount;

  Profile get author;

  factory Article([updates(ArticleBuilder b)]) = _$Article;

  Article._() {
    assert(favoritesCount >= 0);
  }

  static Article fromRequest(Map<String, dynamic> requestData) =>
      serializers.deserializeWith(Article.serializer, requestData['article']);
}

abstract class ArticleList implements Built<ArticleList, ArticleListBuilder> {
  static Serializer<ArticleList> get serializer => _$articleListSerializer;

  BuiltSet<Article> get articles;

  int get articlesCount;

  factory ArticleList([updates(ArticleListBuilder b)]) = _$ArticleList;

  ArticleList._() {
    assert(articlesCount >= 0);
  }

  static ArticleList fromRequest(Map<String, dynamic> requestData) =>
      serializers.deserializeWith(ArticleList.serializer, requestData);
}
