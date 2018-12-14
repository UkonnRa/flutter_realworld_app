import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/components/chipper.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/pages/article_page.dart';
import 'package:flutter_realworld_app/pages/profile_page.dart';
import 'package:flutter_realworld_app/util.dart' as util;

typedef void FollowButtonCallback(Article article);

class ArticleItem extends StatefulWidget {
  final Article _article;

  ArticleItem(this._article, {Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ArticleItemState(_article);
}

class _ArticleItemState extends State<ArticleItem> {
  Article _article;

  _ArticleItemState(this._article);

  _header(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProfilePage(_article.author)));
        },
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 4.0),
              child: CircleAvatar(
                backgroundImage:
                    util.isNullEmpty(_article.author.image, trim: true)
                        ? AssetImage('res/assets/smiley-cyrus.jpg')
                        : CachedNetworkImageProvider(_article.author.image),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(_article.author.username,
                      style: Theme.of(context).textTheme.body2),
                  Text(util.dateFormatter.format(_article.createdAt),
                      style: Theme.of(context).textTheme.caption),
                ],
              ),
            ),
            FlatButton(
              textColor: Theme.of(context).primaryColor,
              onPressed: () async {
                try {
                  final api = await Api.getInstance();
                  Article article;
                  if (_article.favorited) {
                    article = await api.articleUnfavorite(_article.slug);
                  } else {
                    article = await api.articleFavorite(_article.slug);
                  }
                  setState(() {
                    this._article = article;
                  });
                } catch (e) {
                  util.errorHandle(e, context);
                }
              },
              child: Row(
                children: <Widget>[
                  _article.favorited
                      ? Icon(Icons.favorite)
                      : Icon(Icons.favorite_border),
                  Text(_article.favoritesCount.toString())
                ],
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(left: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _header(context),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ArticlePage(_article)));
              },
              child: Column(
                children: <Widget>[
                  Text(_article.title,
                      style: Theme.of(context).textTheme.title),
                  Padding(
                    padding: EdgeInsets.only(bottom: 4.0),
                    child: Text(_article.description),
                  ),
                ],
              ),
            ),
            Wrap(
                spacing: 4.0,
                children: _article.tagList
                    .map((t) => GestureDetector(
                          onTap: () {
                            print("chip tap: $t");
                          },
                          child: Chipper(t),
                        ))
                    .toList()),
            Divider(),
          ],
        ),
      );
}
