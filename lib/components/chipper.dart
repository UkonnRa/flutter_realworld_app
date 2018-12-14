import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/pages/search_result_page.dart';

class Chipper extends StatelessWidget {
  final String _label;
  final bool _canReplaceLastPage;

  const Chipper(this._label, {Key key, bool canReplaceLastPage = false})
      : this._canReplaceLastPage = canReplaceLastPage,
        super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          final route =
              MaterialPageRoute(builder: (context) => SearchResultPage(_label));
          if (_canReplaceLastPage)
            Navigator.pushReplacement(context, route);
          else
            Navigator.push(context, route);
        },
        child: Chip(label: Text(_label)),
      );
}
