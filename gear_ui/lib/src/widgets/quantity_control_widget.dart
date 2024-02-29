import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuantityControlWidget extends StatefulWidget {
  const QuantityControlWidget({
    super.key,
    required this.minimum,
    required this.maximum,
    this.initial = 0,
    this.nullValue = 0,
    this.onChanged,
    this.decrementIcon = const Icon(
      Icons.remove,
    ),
    this.incrementIcon = const Icon(
      Icons.add,
    ),
    this.allowSigned = false,
    this.allowDecimal = false,
    this.enabledEditText = true,
    this.disabledWhenLimited = true,
  });

  final int minimum;
  final int maximum;
  final int initial;
  final int nullValue;
  final ValueChanged<int>? onChanged;
  final bool allowSigned;
  final bool allowDecimal;
  final bool enabledEditText;
  final bool disabledWhenLimited;
  final Widget decrementIcon;
  final Widget incrementIcon;

  @override
  State<QuantityControlWidget> createState() => _QuantityControlWidgetState();
}

class _QuantityControlWidgetState extends State<QuantityControlWidget> {
  final _textController = TextEditingController();
  late int _quantity;

  int get _min => widget.minimum;

  int get _max => widget.maximum;

  bool get _disabledDecrement {
    return widget.disabledWhenLimited && _quantity <= _min;
  }

  bool get _disabledIncrement {
    return widget.disabledWhenLimited && _quantity >= _max;
  }

  void _updateQuantity(bool increment) {
    if (increment) {
      if (_quantity < _max) {
        _quantity++;
      }
    } else {
      if (_quantity > _min) {
        _quantity--;
      }
    }

    setState(() {
      _textController.text = "$_quantity";
      widget.onChanged?.call(_quantity);
    });
  }

  void _handleEditText(String value) {
    int? currentQuantity = int.tryParse(value);
    if (currentQuantity != null && currentQuantity != widget.nullValue) {
      if (currentQuantity < _min) {
        currentQuantity = _min;
      } else if (currentQuantity > _max) {
        currentQuantity = _max;
      }
    } else {
      currentQuantity = widget.nullValue;
    }

    _quantity = currentQuantity;
    setState(() {
      _textController.text = "$_quantity";
      widget.onChanged?.call(_quantity);
    });
  }

  @override
  void initState() {
    super.initState();

    _quantity = widget.initial;
    _textController.text = "$_quantity";
  }

  @override
  void dispose() {
    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: IconButton(
            onPressed: _disabledDecrement
                ? null
                : () {
                    _updateQuantity(false);
                  },
            icon: widget.decrementIcon,
          ),
        ),
        Expanded(
          child: TextField(
            onChanged: _handleEditText,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: _textController,
            minLines: 1,
            maxLines: 1,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.numberWithOptions(
              decimal: widget.allowDecimal,
              signed: widget.allowSigned,
            ),
            enabled: widget.enabledEditText,
          ),
        ),
        Expanded(
          child: IconButton(
            onPressed: _disabledIncrement
                ? null
                : () {
                    _updateQuantity(true);
                  },
            icon: widget.incrementIcon,
          ),
        ),
      ],
    );
  }
}
