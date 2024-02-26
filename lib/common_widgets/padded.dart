import 'package:flutter/material.dart';

class Padded extends StatelessWidget {
  const Padded({
    super.key,
    required this.child,
    this.padding,
    this.topPadding = 12,
    this.bottomPadding = 0,
    this.leftPadding = 0,
    this.rightPadding = 0,
  });
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double topPadding;
  final double bottomPadding;
  final double leftPadding;
  final double rightPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.only(top: topPadding, bottom: bottomPadding, left: leftPadding, right: rightPadding),
      child: child,
    );
  }
}
