import 'dart:async';

class DataStream {
  final _controller = StreamController<String>();

  Stream<String> get stream => _controller.stream;

  void addData(String data) {
    _controller.sink.add(data);
  }

  void dispose() {
    _controller.close();
  }
}