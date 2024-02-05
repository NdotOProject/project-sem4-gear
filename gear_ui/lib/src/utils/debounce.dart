import 'dart:async';

class Debounce<T> {
  Debounce({
    required void Function() onChange,
    this.delay = 500,
  }) : _handleOnChange = onChange;

  final int delay;

  final void Function() _handleOnChange;
  Timer? _timer;

  void call() {
    if (_timer?.isActive ?? false) {
      _timer?.cancel();
    }
    _timer = Timer(Duration(milliseconds: delay), _handleOnChange);
  }

  void cancel() {
    _timer?.cancel();
  }
}
