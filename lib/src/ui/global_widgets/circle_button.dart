import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/app/app_utils.dart';
import '../../utils/colors.dart';

class CircleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final double size;
  final Color backgroundColor, iconColor;

  const CircleButton({
    Key? key,
    required this.onPressed,
    required this.iconPath,
    this.size = 40 - 4,
    this.backgroundColor = primaryColor,
    this.iconColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: onPressed,
      padding: const EdgeInsets.all(2),
      child: Container(
        width: size,
        height: size,
        decoration: const BoxDecoration(
          //color: backgroundColor, // SocialMediaColor
          shape: BoxShape.circle,
        ),
        child: AppUtils.isHtml
            ? Image.network(
                iconPath,
                //color: iconColor, // SocialMediaColor
              )
            : SvgPicture.asset(
                iconPath,
                //color: iconColor, // SocialMediaColor
              ),
      ),
    );
  }
}
