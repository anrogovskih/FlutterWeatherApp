import 'dart:async';

import 'package:flutter/cupertino.dart';

abstract class BaseStreamRepository<T> {

  final _controller = StreamController<T>.broadcast();

  // Input stream. We add our notes to the stream using this variable.
  @protected
  StreamSink<T> get streamSink => _controller.sink;

  // Output stream. This one will be used within our pages to display the locations.
  Stream<T> get stream => _controller.stream;

  // All stream controllers you create should be closed within this function
  void dispose() {
    _controller.close();
  }
}