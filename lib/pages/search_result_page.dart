import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/components/article_item.dart';
import 'package:flutter_realworld_app/components/scrollable_loading_list.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/util.dart' as util;

class SearchResultPage extends StatefulWidget {
  final String _tag;

  const SearchResultPage(this._tag, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchResultPage(_tag);
}

class _SearchResultPage extends State<SearchResultPage> {
  final String _tag;

  _SearchResultPage(this._tag);

  Future<List<Article>> _loadingDataFunction({int offset}) async {
    try {
      final api = await Api.getInstance();
      return (await api.articleListGet(tag: _tag, offset: offset))
          .articles
          .toList();
    } catch (e) {
      util.errorHandle(e, context);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context)),
          title: Text(S.of(context).searchResultPageTitle(_tag)),
        ),
        body: ScrollableLoadingList<Article>(
          loadingDataFunction: _loadingDataFunction,
          itemConstructor: (Article a) => ArticleItem(a),
        ),
      );
}
