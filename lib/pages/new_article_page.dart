import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/models/article.dart';
import 'package:flutter_realworld_app/pages/article_page.dart';
import 'package:flutter_realworld_app/util.dart' as util;

class NewArticlePage extends StatefulWidget {
  final Article _article;

  const NewArticlePage({Key key, Article article})
      : _article = article,
        super(key: key);

  @override
  State<StatefulWidget> createState() => _NewArticlePageState(_article);
}

class _NewArticlePageState extends State<NewArticlePage> {
  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _bodyController = TextEditingController();
  final _tagListController = TextEditingController();

  final bool _isCreateArticle;
  final String _slug;

  _NewArticlePageState(Article article)
      : _isCreateArticle = article == null,
        _slug = article.slug {
    if (article != null) {
      _titleController.text = article.title;
      _descriptionController.text = article.description;
      _bodyController.text = article.body;
      _tagListController.text = article.tagList.reduce((a, b) => "$a, $b");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).newArticlePageTitle),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.send),
              onPressed: () async {
                if (_formKey.currentState.validate()) {
                  final tagList = _tagListController.text
                      .split(",")
                      .map((s) => s.trim())
                      .where((s) => !util.isNullEmpty(s))
                      .toList();
                  util.startLoading(context);
                  try {
                    final api = await Api.getInstance();
                    Article newArticle;
                    if (_isCreateArticle) {
                      newArticle = await api.articleCreate(
                          _titleController.text,
                          _descriptionController.text,
                          _bodyController.text,
                          tagList);
                    } else {
                      newArticle = await api.articleUpdate(
                          _slug,
                          _titleController.text,
                          _descriptionController.text,
                          _bodyController.text,
                          tagList);
                    }
                    util.finishLoading(context);
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => ArticlePage(newArticle)));
                    if (_isCreateArticle) {
                      util.flushbar(
                          context,
                          S.of(context).newArticleSuccessfulTitle,
                          S.of(context).newArticleSuccessful);
                    } else {
                      util.flushbar(
                          context,
                          S.of(context).updateArticleSuccessfulTitle,
                          S.of(context).updateArticleSuccessful);
                    }
                  } catch (e) {
                    util.finishLoading(context);
                    util.errorHandle(e, context);
                  }
                }
              },
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Form(
            autovalidate: true,
            key: _formKey,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: S.of(context).title),
                  validator: (value) {
                    if (util.isNullEmpty(value, trim: true)) {
                      return S.of(context).validatorNotEmpty;
                    }
                  },
                  controller: _titleController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    decoration:
                        InputDecoration(labelText: S.of(context).description),
                    validator: (value) {
                      if (util.isNullEmpty(value, trim: true)) {
                        return S.of(context).validatorNotEmpty;
                      }
                    },
                    controller: _descriptionController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration:
                        InputDecoration(labelText: S.of(context).articleBody),
                    validator: (value) {
                      if (util.isNullEmpty(value)) {
                        return S.of(context).validatorNotEmpty;
                      }
                    },
                    controller: _bodyController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Tooltip(
                    child: TextFormField(
                      decoration:
                          InputDecoration(labelText: S.of(context).tagList),
                      controller: _tagListController,
                    ),
                    message: S.of(context).tagListTooltip,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
