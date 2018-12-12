import 'package:built_collection/built_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/components/article_item.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_realworld_app/pages/setting_page.dart';
import 'package:flutter_realworld_app/util.dart' as util;
import 'package:flutter_redurx/flutter_redurx.dart';
import 'package:tuple/tuple.dart';

class ProfilePage extends StatefulWidget {
  final Profile _profile;

  const ProfilePage(this._profile, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ProfilePageState(this._profile);
}

enum _TabState { MY, FAVORITED }

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  // This is the person you are looking at!!!
  final Profile _profile;

  bool _following;

  TabController _tabController;
  Map<_TabState, Tuple2<DateTime, List<Article>>> _cached;

  List<Tuple2<_TabState, Tab>> get _tabs => [
        Tuple2(
            _TabState.MY,
            Tab(
              icon: Icon(Icons.edit),
              text: S.of(context).myArticles,
            )),
        Tuple2(
            _TabState.FAVORITED,
            Tab(
              icon: Icon(Icons.favorite),
              text: S.of(context).favoritedArticles,
            ))
      ];

  _ProfilePageState(this._profile) {
    this._following = _profile.following;
    this._tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        _getArticles(_TabState.values[_tabController.index]);
      }
    });
    _cached = Map.fromEntries(
        _TabState.values.map((i) => MapEntry(i, Tuple2(DateTime.now(), []))));
  }

  void _getArticles(_TabState code) {
    print("get article $code");
    if (DateTime.now().difference(_cached[code].item1).inMinutes <= 1) {
      return;
    }
    Api.getInstance().then((api) {
      switch (code) {
        case _TabState.MY:
          return api.articleListGet(author: _profile.username);
        case _TabState.FAVORITED:
          return api.articleListGet(favorited: _profile.username);
        default:
          return Future.value(ArticleList((b) => b
            ..articles = SetBuilder()
            ..articlesCount = 0));
      }
    }).then((ArticleList list) {
      setState(() {
        _cached[code] = Tuple2(DateTime.now(), list.articles.toList());
        print("ArticleList: ${list.articles}");
      });
    }).catchError((err) {
      util.errorHandle(err, context);
    });
  }

  MaterialButton _followButton(bool isMe, AuthUser currentUser) {
    if (isMe) return null;
    if (_following)
      return FlatButton(
        color: Theme.of(context).accentColor,
        child: Text(S.of(context).unfollow),
        onPressed: currentUser == null
            ? null
            : () async {
                final api = await Api.getInstance();
                await api.profileUnfollow(_profile.username);
                setState(() {
                  _following = false;
                });
              },
      );
    return FlatButton(
      color: Theme.of(context).accentColor,
      child: Text(S.of(context).follow),
      onPressed: currentUser == null
          ? null
          : () async {
              final api = await Api.getInstance();
              await api.profileFollow(_profile.username);
              setState(() {
                _following = true;
              });
            },
    );
  }

  @override
  Widget build(BuildContext context) => Connect<AppState, AuthUser>(
      where: (AuthUser oldState, AuthUser newState) => oldState != newState,
      convert: (AppState state) => state.currentUser,
      builder: (AuthUser currentUser) {
        final isMe = currentUser.username == _profile.username;
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context,
                    bool innerBoxIsScrolled) =>
                <Widget>[
                  SliverAppBar(
                    elevation: 0.0,
                    expandedHeight: 400.0,
                    pinned: true,
                    leading: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    actions: isMe
                        ? <Widget>[
                            IconButton(
                              icon: Icon(Icons.settings),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SettingPage()));
                              },
                            )
                          ]
                        : null,
                    flexibleSpace: FlexibleSpaceBar(
                        title: Text(S.of(context).profilePageTitle),
                        background: Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).padding.top + 50.0),
                          child: Column(
                            children: <Widget>[
                              CircleAvatar(
                                radius: 50.0,
                                backgroundImage: util.isNullEmpty(
                                            _profile.image,
                                            trim: true) ==
                                        null
                                    ? AssetImage('res/assets/smiley-cyrus.jpg')
                                    : CachedNetworkImageProvider(
                                        _profile.image),
                              ),
                              Stack(
                                children: <Widget>[
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      _profile.username,
                                      style: Theme.of(context)
                                          .textTheme
                                          .display1
                                          .merge(
                                              TextStyle(color: Colors.black)),
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(right: 8.0),
                                      alignment: Alignment.centerRight,
                                      child: _followButton(isMe, currentUser))
                                ].where((Object o) => o != null).toList(),
                              ),
                            ],
                          ),
                        )),
                  ),
                  SliverPersistentHeader(
                    pinned: true,
                    delegate: _SliverAppBarDelegate(
                      TabBar(
                        controller: _tabController,
                        labelColor: Theme.of(context).accentColor,
                        unselectedLabelColor: Colors.grey,
                        tabs: _tabs.map((t) => t.item2).toList(),
                      ),
                    ),
                  )
                ],
            body: Center(
              child: TabBarView(
                controller: _tabController,
                children: _TabState.values.map((_TabState s) {
                  if (_cached[s].item2.isEmpty) {
                    return Center(
                      child: Text("Empty now"),
                    );
                  } else {
                    return ListView(
                      children: _cached[s]
                          .item2
                          .map((Article a) => ArticleItem(a))
                          .toList(),
                    );
                  }
                }).toList(),
              ),
            ),
          ),
        );
      });
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Container(
        color: Colors.white,
        child: Material(
          elevation: 4.0,
          child: _tabBar,
        ),
      );

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
