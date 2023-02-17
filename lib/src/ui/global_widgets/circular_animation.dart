import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularAnimation extends StatefulWidget {
  late double grados;
  late double? begin;
  late double? end;
  late String? img;
  CircularAnimation({
    Key? key,
    required this.grados,
    this.begin,
    this.end,
    this.img,
  }) : super(key: key);

  @override
  State<CircularAnimation> createState() => _CircularAnimationState();
}

class _CircularAnimationState extends State<CircularAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _startAngle;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    );

    _startAngle = Tween<double>(
      begin: widget.begin ?? 0.0, // begin: 230.270,
      end: widget.end ?? 360.0, // end: 0.360,
    ).animate(_controller);

    // Funciona con AnimatedBuilder
    // _startAngle.addListener(() {
    //   setState(() {});
    // });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: AspectRatio(
          aspectRatio: 1,
          child: AnimatedBuilder(
            animation: _startAngle,
            child: Container(
              color: const Color(0xffF9A826),
              child: Image.network(
                widget.img ??
                    'https://www.pngall.com/wp-content/uploads/5/Food-Buffet-PNG-HD-Image.png',
                fit: BoxFit.cover,
              ),
            ),
            builder: (_, child) {
              return ClipPath(
                clipper: MyArcToClipper(
                  startAngle: _startAngle.value,
                  sweepAngle: widget.grados, //grados,
                ),
                child: child,
              );
            },
          ),
        ),
      ),
    );
  }
}

class ClipperAnimation extends StatelessWidget {
  const ClipperAnimation({
    Key? key,
    required Animation<double> startAngle,
  })  : _startAngle = startAngle,
        super(key: key);

  final Animation<double> _startAngle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipPath(
          clipper: MyArcToClipper(
            startAngle: _startAngle.value,
            sweepAngle: 250,
          ),
          child: Container(
            // color: Color(0xffb3e5fc),
            width: 333,
            height: 333,
            child: Image.network(
              'https://p4.wallpaperbetter.com/wallpaper/688/377/243/skyline-stars-city-anime-wallpaper-preview.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class MyArcToClipper extends CustomClipper<Path> {
  final double startAngle, sweepAngle;

  MyArcToClipper({required this.sweepAngle, required this.startAngle});

  double toRadians(double degrees) {
    return degrees * math.pi / 180;
  }

  @override
  Path getClip(Size size) {
    /// TODO Animation circular progres...
    Rect rect = Rect.fromLTRB(0, 0, size.width, size.height);
    Path path = Path();

    final startAngle = toRadians(this.startAngle);
    final sweepAngle = toRadians(this.sweepAngle);

    path.arcTo(rect, startAngle, sweepAngle, false);
    path.lineTo(size.width * 0.5, size.height * 0.5);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
