import 'package:flutter/material.dart';

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

    this.curve = CurvedAnimation(
      parent: this._controller,
      curve: Curves.easeInOut,
    );
    _animation = Tween<double>(begin: 0, end: this.widget.value);
  }

  @override
  void didUpdateWidget(CustomProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    double beginValue =
        _animation?.evaluate(this.curve) ?? oldWidget?.value ?? 0;

    _animation = Tween<double>(
      begin: beginValue,
      end: this.widget.value ?? 1,
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
            backgroundColor: Colors.blue[50],
            value: _animation.evaluate(_controller),
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
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
