import 'package:built_collection/built_collection.dart';
import 'package:built_value/iso_8601_date_time_serializer.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/comment.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/user.dart';

part 'serializers.g.dart';

/// Collection of generated serializers for the built_value chat example.
@SerializersFor(const [
  AuthUser,
  Profile,
  Comment,
  CommentList,
  Article,
  ArticleList,
  AppState
])
final Serializers serializers = (_$serializers.toBuilder()
      ..add(Iso8601DateTimeSerializer())
      ..addPlugin(StandardJsonPlugin()))
    .build();
