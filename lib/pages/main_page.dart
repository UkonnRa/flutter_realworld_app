import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/components/app_drawer.dart';
import 'package:flutter_realworld_app/components/article_item.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_realworld_app/pages/login_page.dart';
import 'package:flutter_redurx/flutter_redurx.dart';

class MainPage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

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
                title: Text(S.of(context).mainPageTitle),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      print("search");
                    },
                  )
                ],
              ),
              drawer: AppDrawer(state.currentUser, state.currentProfile),
              body: FutureBuilder<ArticleList>(
                  future: Api.getInstance().then((api) => api.articleListGet()),
                  builder: (BuildContext context,
                      AsyncSnapshot<ArticleList> snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.none:
                        return Center(
                          child: Text("None found"),
                        );
                      default:
                        return ListView(
                            children: snapshot.data.articles
                                .map((a) => ArticleItem(a))
                                .toList());
                    }
                  }),
              floatingActionButton: _fab(state.currentUser, context),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endFloat,
            ),
      );

  FloatingActionButton _fab(AuthUser user, BuildContext context) => user == null
      ? FloatingActionButton(
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => LoginPage()));
          },
          child: Text(S.of(context).login),
        )
      : FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        );
}
