import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimatedTextWidget extends StatefulWidget {
  final String animatedText;
  final String staticText;

  @override
  _AnimatedTextWidgetState createState() => _AnimatedTextWidgetState();
  AnimatedTextWidget({this.staticText, this.animatedText});
}

class _AnimatedTextWidgetState extends State<AnimatedTextWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<String> animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = TypewriterTween(end: widget.animatedText).animate(controller);
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Text(
          '${widget.staticText}${animation.value}',
          style: TextStyle(
              fontSize: 20, color: Get.isDarkMode ? Colors.blue : Colors.amber),
        );
      },
    );
  }
}

class TypewriterTween extends Tween<String> {
  TypewriterTween({String begin = '', String end})
      : super(begin: begin, end: end);

  String lerp(double t) {
    var cutoff = (end.length * t).round();
    return end.substring(0, cutoff);
  }
}
