import 'package:flutter/material.dart';

class ReusableTextButton extends StatelessWidget {
  const ReusableTextButton({
    super.key,
    this.padding,
    this.margin,
    this.buttonColor,
    required this.buttonText,
    this.border,
    this.borderRadius,
    required this.onTap,
    this.isLoading = false,
    this.buttonTextStyle,
  });
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? buttonColor;
  final String buttonText;
  final Border? border;
  final BorderRadius? borderRadius;
  final void Function()? onTap;
  final bool isLoading;
  final TextStyle? buttonTextStyle;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    final buttonColor = Colors.green.shade200;

    const buttonTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
    return InkWell(
      onTap: onTap,
      borderRadius: this.borderRadius ?? borderRadius,
      child: Container(
        // height: 100,
        // width: 200,
        alignment: Alignment.center,
        padding: padding ?? const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        margin: margin ?? const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: this.buttonColor ?? buttonColor,
            border: border ?? Border.all(width: 1, color: Colors.grey.shade300),
            borderRadius: this.borderRadius ?? borderRadius),
        child: isLoading
            ? SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  color: this.buttonColor ?? buttonColor,
                  strokeWidth: 3,
                ),
              )
            : Text(
                buttonText,
                style: this.buttonTextStyle ?? buttonTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}
