import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ProgressIndicatorType {
  circular,
  linear,
}

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({Key key, this.type, this.value})
      : super(key: key);

  final ProgressIndicatorType type;
  final double value;

  @override
  _CustomProgressIndicatorState createState() =>
      _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> _animation;
  Animation<double> curve;
  double value;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
      animationBehavior: AnimationBehavior.preserve,
    )..forward();

    curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _animation = Tween<double>(begin: 0, end: widget.value);
  }

  @override
  void didUpdateWidget(CustomProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    double beginValue = _animation?.evaluate(curve) ?? oldWidget?.value ?? 0;

    _animation = Tween<double>(
      begin: beginValue,
      end: widget.value ?? 1,
    );
    _controller
      ..value = 0
      ..forward();
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  Widget _buildIndicator(BuildContext context, Widget child) {
    switch (widget.type) {
      case ProgressIndicatorType.circular:
        return CircularProgressIndicator(
            value: _animation.evaluate(_controller));
      case ProgressIndicatorType.linear:
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: LinearProgressIndicator(
            minHeight: 10,
            backgroundColor: Get.isDarkMode
                ? Get.theme.scaffoldBackgroundColor
                : Colors.blue[50],
            value: _animation.evaluate(_controller),
            valueColor: AlwaysStoppedAnimation<Color>(Get.theme.primaryColor),
          ),
        );
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: _buildIndicator,
    );
  }
}
