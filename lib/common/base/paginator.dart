import 'dart:async';

class Paginator<T> {
  final int pageSize;
  int _totalPages = 1;

  int _currentPage = 0;
  bool _isFetching = false;
  bool _hasMoreData = true;
  final List<T> _data = [];

  final StreamController<List<T>> _dataController =
      StreamController<List<T>>.broadcast();

  Paginator({
    this.pageSize = 10,
  });

  void setTotalPages(int pageSize) {
    _totalPages = pageSize;
  }

  /// Stream to listen to paginated data updates.
  Stream<List<T>> get dataStream => _dataController.stream;

  /// Returns the current list of data.
  List<T> get data => List.unmodifiable(_data);

  /// Checks if there is more data to fetch.
  bool get hasMoreData => _hasMoreData;

  /// Add Data To List.
  void addData(List<T> data){
    _data.addAll(data);
    _dataController.add(_data);
  }
  /// Fetches the next page of data.
  Future<void> fetchNextPage(
      {required Future<void> Function(int page, int pageSize)
          fetchPage}) async {
    if (_isFetching || !_hasMoreData) return;

    _isFetching = true;
    try {
      await fetchPage(_currentPage + 1, pageSize);

      if (_currentPage + 1 >= _totalPages) {
        _hasMoreData = false;
        _currentPage++;
      } else {
        _currentPage++;
      }
    } catch (e) {
      _dataController.addError(e);
    } finally {
      _isFetching = false;
    }
  }

  /// Resets the paginator to its initial state.
  Future<void> reset() async {
    _currentPage = 0;
    _totalPages = 1;
    _isFetching = false;
    _hasMoreData = true;
    _data.clear();
    _dataController.add(_data);
  }

  /// Disposes the paginator and closes the stream controller.
  void dispose() {
    _dataController.close();
  }
}
