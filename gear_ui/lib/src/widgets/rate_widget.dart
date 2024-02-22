import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RateWidget extends StatefulWidget {
  const RateWidget({
    super.key,
    required this.iconCount,
    this.initialValue = 0.0,
    this.icon = RateIcon.star,
    this.enabled = true,
  });

  final int iconCount;
  final RateIcon icon;
  final double initialValue;
  final bool enabled;

  @override
  State<RateWidget> createState() => _RateWidgetState();
}

class _RateWidgetState extends State<RateWidget> {
  Widget _iconBuilder() {
    switch (widget.icon) {
      case RateIcon.star:
        // Icons.star
        break;
      case RateIcon.heart:
        break;
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [],
    );
  }
}

enum RateIcon {
  star,
  heart,
}
