import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/api.dart';
import 'package:flutter_realworld_app/components/chipper.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';
import 'package:flutter_realworld_app/util.dart' as util;

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(S.of(context).search),
        ),
        body: FutureBuilder(
          future: Api.getInstance()
              .then((api) => api.tagGet())
              .catchError((e) => util.errorHandle(e, context)),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (snapshot.hasData) {
              final tags = snapshot.data;
              return Center(
                child: Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Text(
                        S.of(context).searchByTagInfo,
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Wrap(
                      spacing: 4.0,
                      children: tags
                          .map(
                            (s) => Chipper(s, canReplaceLastPage: true),
                          )
                          .toList(),
                    ),
                  ],
                ),
              );
            } else
              return Center(
                child: CircularProgressIndicator(),
              );
          },
        ),
      );
}
