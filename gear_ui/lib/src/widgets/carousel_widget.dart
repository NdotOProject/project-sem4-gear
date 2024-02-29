import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselWidget<T> extends StatefulWidget {
  const CarouselWidget({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.initialPage = 0,
    this.autoPlayOptions,
    this.indicator,
    this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.8,
    this.curve = Curves.easeInOut,
    this.disableGesture,
    this.disableCenter = false,
    this.enableInfiniteScroll = true,
  });

  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final CarouselIndicator? indicator;
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

  late final Map<int, Widget> _itemsAsWidgets;

  late int _activePage;

  final _controller = CarouselController();

  void _handleChangeActivePage(int index, CarouselPageChangedReason reason) {
    setState(() {
      _activePage = index;
    });
  }

  void _handleIndicatorItemClick(int index) {
    _controller.animateToPage(index);
  }

  @override
  void initState() {
    super.initState();

    _activePage = widget.initialPage;

    _itemsAsWidgets = widget.items.asMap().map((index, item) {
      return MapEntry<int, Widget>(
        index,
        widget.itemBuilder(context, item),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final AutoPlayOptions autoPlayOptions = (widget.autoPlayOptions != null)
        ? widget.autoPlayOptions!
        : const AutoPlayOptions();

    final Widget carousel = CarouselSlider(
      items: _itemsAsWidgets.values.toList(),
      carouselController: _controller,
      disableGesture: widget.disableGesture,
      options: CarouselOptions(
        onPageChanged: _handleChangeActivePage,
        autoPlayCurve: widget.curve,
        height: widget.height,
        aspectRatio: widget.aspectRatio,
        viewportFraction: widget.viewportFraction,
        initialPage: _activePage,
        enableInfiniteScroll: widget.enableInfiniteScroll,
        autoPlay: widget.autoPlayOptions != null,
        autoPlayInterval: autoPlayOptions.duration,
        autoPlayAnimationDuration: autoPlayOptions.animationDuration,
        pauseAutoPlayOnTouch: autoPlayOptions.pauseOnTouch,
        pauseAutoPlayOnManualNavigate: autoPlayOptions.pauseOnManualNavigate,
        pauseAutoPlayInFiniteScroll: autoPlayOptions.pauseInFiniteScroll,
        enlargeCenterPage: true,
        disableCenter: widget.disableCenter,
      ),
    );

    if (widget.indicator != null) {
      final CarouselIndicator indicatorConfig = widget.indicator!;

      final Widget indicator = _buildIndicator(
        context: context,
        indicator: indicatorConfig,
        animationDuration: autoPlayOptions.animationDuration ~/ 2,
      );

      if (indicatorConfig.innerIndicator) {
        final IndicatorPosition position = indicatorConfig.position;
        return Stack(
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
        return Column(
          children: <Widget>[
            carousel,
            indicator,
          ],
        );
      }
    }

    return carousel;
  }

  Widget _buildIndicator({
    required BuildContext context,
    required Duration animationDuration,
    required CarouselIndicator indicator,
  }) {
    final ThemeData theme = Theme.of(context);

    final double width =
        indicator.width ?? indicator.size ?? _defaultIndicatorSize;

    final double height =
        indicator.height ?? indicator.size ?? _defaultIndicatorSize;

    final Color color = indicator.color ?? theme.indicatorColor;
    final Color activeColor = indicator.activeColor ?? theme.primaryColor;

    Widget? result;

    if (indicator.type == IndicatorTypes.reflectsContent) {
      result = SizedBox(
        height: height,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.hardEdge,
          children: <Widget>[
            ..._itemsAsWidgets.map((index, contentWidget) {
              final bool active = _activePage == index;
              return MapEntry<int, Widget>(
                index,
                GestureDetector(
                  onTap: () {
                    _handleIndicatorItemClick(index);
                  },
                  child: AnimatedOpacity(
                    opacity: active ? 1 : 0.5,
                    duration: animationDuration,
                    child: Container(
                      width: width,
                      height: height,
                      padding: EdgeInsets.all(
                        indicator.borderWidth,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: indicator.itemsGap / 2,
                      ),
                      decoration: BoxDecoration(
                        color: active ? activeColor : color,
                        borderRadius: indicator.borderRadius,
                      ),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: indicator.borderRadius.subtract(
                            BorderRadius.circular(
                              indicator.borderWidth,
                            ),
                          ),
                        ),
                        child: contentWidget,
                      ),
                    ),
                  ),
                ),
              );
            }).values,
          ],
        ),
      );
    } else {
      IndicatorEffect effect;

      final double radiusValue;
      final BorderRadius radius = indicator.borderRadius.resolve(null);

      if (radius.topRight == radius.topLeft &&
          radius.topRight == radius.bottomRight &&
          radius.bottomRight == radius.bottomLeft) {
        radiusValue = radius.topLeft.x;
      } else {
        radiusValue = height / 2;
      }

      if (indicator.type == IndicatorTypes.worm) {
        effect = WormEffect(
          dotWidth: width,
          dotHeight: height,
          dotColor: color,
          activeDotColor: activeColor,
          spacing: indicator.itemsGap,
          radius: radiusValue,
          strokeWidth: indicator.borderWidth,
        );
      } else {
        effect = ExpandingDotsEffect(
          dotWidth: width,
          dotHeight: height,
          dotColor: color,
          activeDotColor: activeColor,
          spacing: indicator.itemsGap,
          radius: radiusValue,
          strokeWidth: indicator.borderWidth,
        );
      }

      result = AnimatedSmoothIndicator(
        activeIndex: _activePage,
        count: _itemsAsWidgets.length,
        curve: widget.curve,
        onDotClicked: _handleIndicatorItemClick,
        effect: effect,
      );
    }

    if (indicator.margin != null) {
      result = Padding(
        padding: indicator.margin!,
        child: result,
      );
    }

    return result;
  }
}

class AutoPlayOptions {
  const AutoPlayOptions({
    this.duration = const Duration(seconds: 4),
    this.animationDuration = const Duration(milliseconds: 800),
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

class CarouselIndicator {
  const CarouselIndicator({
    required this.type,
    this.innerIndicator = false,
    this.position = const IndicatorPosition(),
    this.height,
    this.width,
    this.size,
    this.borderRadius = BorderRadius.zero,
    this.borderWidth = 0,
    this.color,
    this.activeColor,
    this.itemsGap = 0,
    this.margin,
  });

  final IndicatorTypes type;
  final bool innerIndicator;
  final IndicatorPosition position;
  final double? height;
  final double? width;
  final double? size;
  final BorderRadiusGeometry borderRadius;
  final double borderWidth;
  final Color? color;
  final Color? activeColor;
  final double itemsGap;
  final EdgeInsetsGeometry? margin;
}

enum IndicatorTypes {
  expandingDot,
  worm,
  reflectsContent,
}

class IndicatorPosition {
  const IndicatorPosition({
    this.top,
    this.bottom,
    this.left,
    this.right,
  });

  final double? top;
  final double? left;
  final double? bottom;
  final double? right;
}
