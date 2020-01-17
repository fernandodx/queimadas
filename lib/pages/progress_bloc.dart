import 'dart:async';

class ProgressBloc {

  StreamController _controller = StreamController<bool>();
  Stream get stream => _controller.stream;

  void showProgress(){
    _controller.add(true);
  }

  void stopProgress() {
    _controller.add(false);
  }

  void dispose() {
    _controller.close();
  }

}