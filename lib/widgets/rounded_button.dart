import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final void Function() onPress;
  final Color textColor;
  final Color color;
  final Widget icon;
  final double height;
  final double width;
  const RoundedButton({
    @required this.text,
    @required this.onPress,
    this.height,
    this.width,
    this.textColor = Colors.white,
    this.color = Colors.black,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: this.width ?? size.width * 0.8,
        height: height,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: TextButton(
            style: TextButton.styleFrom(
                padding: EdgeInsets.all(10), backgroundColor: color),
            onPressed: onPress,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      text,
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                icon ??
                    Container(
                      width: 0,
                      height: 0,
                    ),
              ],
            ),
          ),
        ));
  }
}
