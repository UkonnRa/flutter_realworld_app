import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_redurx/flutter_redurx.dart';

class ChangeEmail extends Action<Article> {
  @override
  Article reduce(Article state) =>
    state.rebuild((b) => b
      ..favoritesCount += 1);
}
