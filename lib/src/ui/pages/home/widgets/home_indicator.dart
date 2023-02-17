import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../../../utils/colors.dart';

class HomeTabBarIndicator extends Decoration {
  final Color color;
  final double size;

  const HomeTabBarIndicator({
    this.color = primaryColor,
    this.size = 3.33,
  }) : assert(size > 0);

  @override
  BoxPainter createBoxPainter([void Function()? onChanged]) {
    return _CustomPainter(color, size);
  }
}

class _CustomPainter extends BoxPainter {
  final Color color;
  final double size;

  _CustomPainter(this.color, this.size);

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    final Paint paint = Paint();
    paint.color = color;
    final width = configuration.size?.width;
    final height = configuration.size?.height;
    final Offset pos = Offset(offset.dx + width! / 2, offset.dy + height! - 3);
    canvas.drawCircle(pos, size, paint);
  }
}
