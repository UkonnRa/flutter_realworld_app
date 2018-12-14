import 'package:flutter/material.dart';
import 'package:flutter_realworld_app/generated/i18n.dart';

typedef Future<List<T>> LoadingDataFunction<T>({int offset});
typedef Widget ItemConstructor<T>(T item);

class ScrollableLoadingList<T> extends StatefulWidget {
  final LoadingDataFunction<T> _loadingDataFunction;
  final ItemConstructor<T> _itemConstructor;

  ScrollableLoadingList({
    Key key,
    @required LoadingDataFunction<T> loadingDataFunction,
    @required ItemConstructor<T> itemConstructor,
  })  : this._loadingDataFunction = loadingDataFunction,
        this._itemConstructor = itemConstructor,
        super(key: key) {
    assert(this._loadingDataFunction != null);
    assert(this._itemConstructor != null);
  }

  @override
  State<StatefulWidget> createState() =>
      _ScrollableLoadingListState(_loadingDataFunction, _itemConstructor);
}

class _ScrollableLoadingListState<T> extends State<ScrollableLoadingList<T>> {
  final LoadingDataFunction<T> _loadingDataFunction;
  final ItemConstructor<T> _itemConstructor;

  List<T> _data = [];
  bool _isPerformingRequest = false;
  ScrollController _scrollController = new ScrollController();

  _ScrollableLoadingListState(this._loadingDataFunction, this._itemConstructor);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
    _getMoreData();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Opacity(
          opacity: _isPerformingRequest ? 1.0 : 0.0,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> _getMoreData() async {
    if (!_isPerformingRequest) {
      setState(() => _isPerformingRequest = true);
      List<T> nextData = await _loadingDataFunction(offset: _data.length);
      nextData = nextData.where((a) => !_data.contains(a)).toList();
      if (nextData.isEmpty && _data.isNotEmpty) {
        double edge = 50.0;
        double offsetFromBottom = _scrollController.position.maxScrollExtent -
            _scrollController.position.pixels;
        if (offsetFromBottom < edge) {
          _scrollController.animateTo(
              _scrollController.offset - (edge - offsetFromBottom),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      setState(() {
        _data.addAll(nextData);
        _isPerformingRequest = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isPerformingRequest) {
      return Center(child: CircularProgressIndicator());
    }
    return _data.isEmpty
        ? Container(
            padding: EdgeInsets.only(top: 50.0),
            alignment: Alignment.center,
            child: Wrap(
              children: <Widget>[
                Icon(
                  Icons.loop,
                  size: 50.0,
                ),
                Text(
                  S.of(context).emptyNow,
                  style: Theme.of(context).textTheme.display1,
                ),
              ],
            ),
          )
        : ListView.builder(
            controller: _scrollController,
            itemCount: _data.length + 1,
            itemBuilder: (context, index) {
              if (index == _data.length) return _buildProgressIndicator();
              return _itemConstructor(_data[index]);
            },
          );
  }
}
