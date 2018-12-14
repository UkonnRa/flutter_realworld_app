import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/components/article_item.dart';
import 'package:flutter_realworld_app/components/scrollable_loading_list.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/user.dart';
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
  bool _following = false;
  TabController _tabController;

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

  @override
  void initState() {
    super.initState();
    Api.getInstance()
        .then((api) => api.profileGet(_profile.username))
        .then((p) => setState(() => _following = p.following));
  }

  _ProfilePageState(this._profile) {
    this._tabController = TabController(length: 2, vsync: this);
  }

  MaterialButton _followButton(bool isMe, AuthUser currentUser) {
    if (isMe || currentUser == null) return null;
    if (_following)
      return FlatButton(
        color: Theme.of(context).accentColor,
        child: Text(S.of(context).unfollow),
        onPressed: currentUser == null
            ? null
            : () async {
                final api = await Api.getInstance();
                final newProfile = await api.profileUnfollow(_profile.username);
                setState(() {
                  _following = newProfile.following;
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
              final newProfile = await api.profileFollow(_profile.username);
              setState(() {
                _following = newProfile.following;
              });
            },
    );
  }

  Widget _tabbar() => Container(
        color: Colors.white,
        child: Material(
          elevation: 4.0,
          child: TabBar(
            controller: _tabController,
            labelColor: Theme.of(context).accentColor,
            unselectedLabelColor: Colors.grey,
            tabs: _tabs.map((t) => t.item2).toList(),
          ),
        ),
      );

  Widget _header(bool isMe, AppState state, String imageUrl) => Container(
        padding: EdgeInsets.only(bottom: 4.0),
        alignment: Alignment.center,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              backgroundImage: util.isNullEmpty(imageUrl, trim: true) == null
                  ? AssetImage('res/assets/smiley-cyrus.jpg')
                  : CachedNetworkImageProvider(imageUrl),
            ),
            Text(
              _profile.username,
              style: Theme.of(context)
                  .textTheme
                  .display1
                  .merge(TextStyle(color: Colors.black)),
            ),
            _profile.bio == null
                ? null
                : Text(
                    _profile.bio,
                    style: Theme.of(context).textTheme.caption,
                  ),
            _followButton(isMe, state.currentUser),
          ].where((o) => o != null).toList(),
        ),
      );

  Widget _tabbarBody() => Expanded(
        child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: _TabState.values
              .map(
                (_TabState s) => ScrollableLoadingList<Article>(
                      itemConstructor: (Article a) => ArticleItem(a),
                      loadingDataFunction: ({int offset}) async {
                        final api = await Api.getInstance();
                        List<Article> articles = [];
                        if (s == _TabState.FAVORITED) {
                          articles = (await api.articleListGet(
                                  favorited: _profile.username))
                              .articles
                              .toList();
                        } else if (s == _TabState.MY) {
                          articles = (await api.articleListGet(
                                  author: _profile.username))
                              .articles
                              .toList();
                        }
                        return articles;
                      },
                    ),
              )
              .toList(),
        ),
      );

  @override
  Widget build(BuildContext context) => Connect<AppState, AppState>(
        where: (AppState oldState, AppState newState) => oldState != newState,
        convert: (AppState state) => state,
        builder: (AppState state) {
          final isMe = state.currentUser?.username == _profile.username;
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(S.of(context).profilePageTitle),
            ),
            body: Column(
              children: <Widget>[
                _header(isMe, state, _profile.image),
                _tabbar(),
                _tabbarBody(),
              ],
            ),
          );
          ;
        },
      );
}
