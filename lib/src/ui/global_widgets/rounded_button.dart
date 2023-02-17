import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';
import '../../utils/font_styles.dart';

class RoundedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Color textColor, backgroundColor, borderColor;
  final bool fullWidth;
  final EdgeInsets padding;
  final double? fontSize;
  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.textColor = Colors.black,
    this.backgroundColor = primaryColor,
    this.borderColor = Colors.black,
    this.fullWidth = true,
    this.fontSize = 22,
    this.padding = const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 33,
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          width: fullWidth ? double.maxFinite : null,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 4,
              color: borderColor,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: MyFontStyles.button.copyWith(
              fontWeight: FontWeight.normal,
              color: textColor,
              fontSize: fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
