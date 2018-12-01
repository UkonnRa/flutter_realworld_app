import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:flutter_realworld_app/models/profile.dart';

part 'comment.g.dart';

abstract class Comment implements Built<Comment, CommentBuilder> {
  static Serializer<Comment> get serializer => _$commentSerializer;

  int get id;
  DateTime get createdAt;
  DateTime get updatedAt;
  String get body;
  Profile get author;

  factory Comment([updates(CommentBuilder b)]) = _$Comment;
  Comment._();
}

abstract class CommentList implements Built<CommentList, CommentListBuilder> {
  static Serializer<CommentList> get serializer => _$commentListSerializer;

  BuiltSet<Comment> get comments;

  factory CommentList([updates(CommentListBuilder b)]) = _$CommentList;
  CommentList._();
}
