import 'dart:async';
import 'dart:ui';

class Debounce<T> {
  Debounce({
    required T Function() onChange,
    this.delay = 500,
    T? init,
  })  : _handleOnChange = onChange,
        _value = init;

  final int delay;

  final T Function() _handleOnChange;
  Timer? _timer;
  T? _value;

  T? get value => _value;

  VoidCallback call() => () {
        if (_timer?.isActive ?? false) {
          _timer?.cancel();
        }
        _timer = Timer(Duration(milliseconds: delay), () {
          _value = _handleOnChange();
        });
      };

  void cancel() {
    _timer?.cancel();
  }
}
