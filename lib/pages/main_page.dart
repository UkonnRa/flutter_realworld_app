import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/components/app_drawer.dart';
import 'package:flutter_realworld_app/components/article_item.dart';
import 'package:flutter_realworld_app/components/scrollable_loading_list.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_realworld_app/util.dart' as util;
import 'package:flutter_redurx/flutter_redurx.dart';

enum MainPageType { YOUR_FEED, GLOBAL_FEED }

class MainPage extends StatefulWidget {
  final MainPageType _type;

  MainPage(this._type, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState(this._type);
}

class _MainPageState extends State<MainPage> {
  final MainPageType _type;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  _MainPageState(this._type);

  String _getSubtitle(BuildContext context) {
    switch (_type) {
      case MainPageType.GLOBAL_FEED:
        return S.of(context).globalFeed;
      case MainPageType.YOUR_FEED:
        return S.of(context).yourFeed;
      default:
        return null;
    }
  }

  FloatingActionButton _fab(AuthUser currentUser, BuildContext context) =>
      currentUser == null
          ? FloatingActionButton(
              shape: StadiumBorder(),
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: Text(S.of(context).login),
            )
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/newArticle');
              },
              child: Icon(Icons.add),
            );

  Future<List<Article>> _loadingDataFunction({int offset}) async {
    try {
      final api = await Api.getInstance();
      List<Article> articles = [];
      if (_type == MainPageType.YOUR_FEED) {
        articles =
            (await api.articleListFeed(offset: offset)).articles.toList();
      } else if (_type == MainPageType.GLOBAL_FEED) {
        articles = (await api.articleListGet(offset: offset)).articles.toList();
      }
      return articles;
    } catch (e) {
      util.errorHandle(e, context);
      return [];
    }
  }

  @override
  Widget build(BuildContext context) => Connect<AppState, AppState>(
        convert: (AppState state) => state,
        where: (AppState oldState, AppState newState) => oldState != newState,
        builder: (AppState state) => Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                leading: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      _scaffoldKey.currentState.openDrawer();
                    }),
                title: Text(
                    "${S.of(context).mainPageTitle} -- ${_getSubtitle(context)}"),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      Navigator.pushNamed(context, '/search');
                    },
                  )
                ],
              ),
              drawer: AppDrawer(state.currentUser),
              body: ScrollableLoadingList<Article>(
                loadingDataFunction: _loadingDataFunction,
                itemConstructor: (Article a) => ArticleItem(a),
              ),
              floatingActionButton: _fab(state.currentUser, context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
            ),
      );
}
