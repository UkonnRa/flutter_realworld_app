import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/components/chipper.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/app_state.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/models/profile.dart';
import 'package:flutter_realworld_app/models/user.dart';
import 'package:flutter_realworld_app/pages/main_page.dart';
import 'package:flutter_realworld_app/pages/new_article_page.dart';
import 'package:flutter_realworld_app/util.dart' as util;
import 'package:flutter_redurx/flutter_redurx.dart';

enum MoreOption { EDIT, DELETE }

class ArticlePage extends StatefulWidget {
  final Article _article;

  const ArticlePage(this._article, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticlePageState(this._article);
}

class _ArticlePageState extends State<ArticlePage> {
  Article _article;

  _ArticlePageState(this._article);

  bool _isMe(AuthUser currentUser) => currentUser == null
      ? false
      : (currentUser.username == _article.author.username);

  MaterialButton _followButton(AuthUser currentUser, Profile profile) {
    if (currentUser == null) return null;
    if (_isMe(currentUser)) return null;

    if (profile.following)
      return FlatButton(
        color: Theme.of(context).accentColor,
        child: Text(S.of(context).unfollow),
        onPressed: () async {
          try {
            final api = await Api.getInstance();
            final newProfile = await api.profileUnfollow(profile.username);
            setState(() {
              _article =
                  _article.rebuild((b) => b..author = newProfile.toBuilder());
            });
          } catch (e) {
            util.errorHandle(e, context);
          }
        },
      );
    return FlatButton(
      color: Theme.of(context).accentColor,
      child: Text(S.of(context).follow),
      onPressed: () async {
        try {
          final api = await Api.getInstance();
          final newProfile = await api.profileFollow(profile.username);
          setState(() {
            _article =
                _article.rebuild((b) => b..author = newProfile.toBuilder());
          });
        } catch (e) {
          util.errorHandle(e, context);
        }
      },
    );
  }

  List<Widget> _moreButton(AuthUser currentUser) => _isMe(currentUser)
      ? [
          PopupMenuButton<MoreOption>(
            itemBuilder: (context) => <PopupMenuEntry<MoreOption>>[
                  PopupMenuItem(
                    child: Text(S.of(context).edit),
                    value: MoreOption.EDIT,
                  ),
                  PopupMenuItem(
                    child: Text(S.of(context).delete),
                    value: MoreOption.DELETE,
                  ),
                ],
            onSelected: (MoreOption op) {
              switch (op) {
                case MoreOption.EDIT:
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NewArticlePage(
                                article: _article,
                              )));
                  break;
                case MoreOption.DELETE:
                  util.showWarningDialog(context,
                      title: S.of(context).deleteArticleTitle,
                      content: S.of(context).deleteArticle,
                      okCallback: () {
                        Api.getInstance()
                            .then((api) => api.articleDelete(_article.slug))
                            .catchError((e) {
                          Navigator.pop(context);
                          util.errorHandle(e, context);
                        }).then((_) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MainPage(MainPageType.YOUR_FEED)),
                              ModalRoute.withName('/'));
                          util.flushbar(
                              context,
                              S.of(context).deleteArticleSuccessfulTitle,
                              S
                                  .of(context)
                                  .deleteArticleSuccessful(_article.title));
                        });
                      },
                      rejectCallback: () => Navigator.pop(context));
                  break;
                default:
                  util.errorHandle(
                      ArgumentError(S.of(context).generalBizarreError),
                      context);
              }
            },
          )
        ]
      : null;

  @override
  Widget build(BuildContext context) {
    return Connect<AppState, AppState>(
        where: (AppState oldState, AppState newState) => oldState != newState,
        convert: (AppState state) => state,
        builder: (AppState state) {
          return FutureBuilder<Profile>(
              future: Api.getInstance()
                  .then((api) => api.profileGet(_article.author.username))
                  .catchError((err) => util.errorHandle(err, context)),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final profile = snapshot.data;
                  return Scaffold(
                    body: NestedScrollView(
                      headerSliverBuilder: (BuildContext context,
                              bool innerBoxIsScrolled) =>
                          <Widget>[
                            SliverAppBar(
                              expandedHeight: 200,
                              pinned: true,
                              primary: true,
                              leading: IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  }),
                              actions: _moreButton(state.currentUser),
                              flexibleSpace: FlexibleSpaceBar(
                                title: Text(S.of(context).article),
                                background: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).padding.top +
                                          50.0,
                                      left: 8.0,
                                      right: 8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 4.0),
                                            child: CircleAvatar(
                                              backgroundImage: util.isNullEmpty(
                                                          _article.author.image,
                                                          trim: true) ==
                                                      null
                                                  ? AssetImage(
                                                      'res/assets/smiley-cyrus.jpg')
                                                  : CachedNetworkImageProvider(
                                                      _article.author.image),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(_article.author.username),
                                                Text(util.dateFormatter.format(
                                                    _article.createdAt)),
                                              ],
                                            ),
                                          ),
                                          _followButton(
                                              state.currentUser, profile),
                                        ].where((w) => w != null).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                      body: Container(
                        padding:
                            EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                        child: ListView(
                          padding: EdgeInsets.only(bottom: 8.0),
                          children: <Widget>[
                            Text(
                              _article.title,
                              style: Theme.of(context).textTheme.display1,
                            ),
                            Wrap(
                              spacing: 8.0,
                              children: _article.tagList
                                  .map((s) => GestureDetector(
                                        onTap: () {},
                                        child: Chipper(s),
                                      ))
                                  .toList(),
                            ),
                            Divider(),
                            MarkdownBody(data: _article.body),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(S.of(context).article),
                    ),
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              });
        });
  }
}
