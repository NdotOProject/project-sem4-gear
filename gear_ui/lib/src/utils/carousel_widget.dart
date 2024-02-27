import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWidget<T> extends StatefulWidget {
  const CarouselWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    // this.indicator,
    this.indicatorTypes,
    this.innerIndicator = false,
    this.indicatorPosition,
    this.indicatorWidth,
    this.indicatorHeight,
    this.curve = Curves.easeInOut,
    this.disableGesture,
    this.disableCenter = false,
    this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.8,
    this.initialPage = 0,
    this.enableInfiniteScroll = true,
    this.autoPlayOptions,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;

  // final Widget? indicator;
  final IndicatorTypes? indicatorTypes;
  final bool innerIndicator;
  final IndicatorPosition? indicatorPosition;
  final double? indicatorWidth;
  final double? indicatorHeight;
  final AutoPlayOptions? autoPlayOptions;
  final Curve curve;
  final bool? disableGesture;
  final bool disableCenter;
  final double? height;
  final double aspectRatio;
  final double viewportFraction;
  final int initialPage;
  final bool enableInfiniteScroll;

  @override
  State<CarouselWidget<T>> createState() => _CarouselWidgetState<T>();
}

class _CarouselWidgetState<T> extends State<CarouselWidget<T>> {
  static const double _defaultIndicatorSize = 16;
  static const double _defaultIndicatorBorderWidth = 2;
  static const double _defaultIndicatorBorderRadius = 10;

  List<T> get _items => widget.items;
  late int _activePage;

  final _controller = CarouselController();

  void _handleChangeActivePage(int index, CarouselPageChangedReason reason) {
    setState(() {
      _activePage = index;
    });
  }

  void _handleIndicatorItemClick(int index) {}

  @override
  void initState() {
    super.initState();

    _activePage = widget.initialPage;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final bool autoPlay = widget.autoPlayOptions != null;
    final AutoPlayOptions autoPlayOptions;

    if (widget.autoPlayOptions != null) {
      autoPlayOptions = widget.autoPlayOptions!;
    } else {
      autoPlayOptions = AutoPlayOptions();
    }

    final Widget carousel = CarouselSlider(
      items: <Widget>[
        ..._items.map((item) {
          return widget.itemBuilder(context, item);
        }),
      ],
      options: CarouselOptions(
        onPageChanged: _handleChangeActivePage,
        autoPlayCurve: widget.curve,
        height: widget.height,
        aspectRatio: widget.aspectRatio,
        viewportFraction: widget.viewportFraction,
        initialPage: _activePage,
        enableInfiniteScroll: widget.enableInfiniteScroll,
        autoPlay: autoPlay,
        autoPlayInterval: autoPlayOptions.duration,
        autoPlayAnimationDuration: autoPlayOptions.animationDuration,
        enlargeCenterPage: true,
        pauseAutoPlayOnTouch: autoPlayOptions.pauseOnTouch,
        pauseAutoPlayOnManualNavigate: autoPlayOptions.pauseOnManualNavigate,
        pauseAutoPlayInFiniteScroll: autoPlayOptions.pauseInFiniteScroll,
        disableCenter: widget.disableCenter,
      ),
      carouselController: _controller,
      disableGesture: widget.disableGesture,
    );

    final Widget result;
    if (widget.indicatorTypes != null) {
      final Widget indicator;
      switch (widget.indicatorTypes!) {
        case IndicatorTypes.dot:
        case IndicatorTypes.expandingDot:
          indicator = AnimatedSmoothIndicator(
            activeIndex: _activePage,
            count: _items.length,
            curve: widget.curve,
            onDotClicked: _handleIndicatorItemClick,
            effect: ExpandingDotsEffect(
              dotWidth: widget.indicatorWidth ?? _defaultIndicatorSize,
              dotHeight: widget.indicatorHeight ?? _defaultIndicatorSize,
              activeDotColor: theme.primaryColor,
              dotColor: theme.indicatorColor,
            ),
          );
        case IndicatorTypes.reflect:
          indicator = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ..._items.map((item) {
                return Container(
                  width: widget.indicatorWidth ?? _defaultIndicatorSize,
                  height: widget.indicatorHeight ?? _defaultIndicatorSize,
                  padding: const EdgeInsets.all(_defaultIndicatorBorderWidth),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      _defaultIndicatorBorderRadius,
                    ),
                    color: theme.primaryColor,
                  ),
                  child: widget.itemBuilder(context, item),
                );
              }),
            ],
          );
      }

      if (widget.innerIndicator) {
        final IndicatorPosition position =
            widget.indicatorPosition ?? const IndicatorPosition();
        result = Stack(
          children: <Widget>[
            carousel,
            Positioned(
              top: position.top,
              bottom: position.bottom,
              right: position.right,
              left: position.left,
              child: indicator,
            ),
          ],
        );
      } else {
        result = Column(
          children: <Widget>[
            carousel,
            indicator,
          ],
        );
      }
    } else {
      result = carousel;
    }

    return result;
  }
}

class AutoPlayOptions {
  static const Duration _defaultDuration = Duration(seconds: 4);
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 800);

  AutoPlayOptions({
    this.duration = _defaultDuration,
    this.animationDuration = _defaultAnimationDuration,
    this.pauseOnTouch = true,
    this.pauseOnManualNavigate = true,
    this.pauseInFiniteScroll = false,
  });

  final Duration duration;
  final Duration animationDuration;
  final bool pauseOnTouch;
  final bool pauseOnManualNavigate;
  final bool pauseInFiniteScroll;
}

enum IndicatorTypes {
  expandingDot,
  dot,
  reflect,
}

class IndicatorPosition {
  const IndicatorPosition({
    this.top = 0,
    this.bottom = 0,
    this.left = 0,
    this.right = 0,
  });

  final double top;
  final double left;
  final double bottom;
  final double right;
}
