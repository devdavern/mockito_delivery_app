import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dots_indicator/dots_indicator.dart';

import '../../../../routes/routes.dart';
import '../../../../utils/colors.dart';
import '../../../global_widgets/rounded_button.dart';
import '../onboard_controller.dart';

class OnboardControls extends StatelessWidget {
  const OnboardControls({
    Key? key,
  }) : super(key: key);

  void _onNext(BuildContext context, OnboardController controller) {
    if (controller.currentPage == 2) {
      Navigator.pushReplacementNamed(context, Routes.welcome);
    } else {
      controller.pageController.nextPage(
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _Dots(),
          Consumer<OnboardController>(
            builder: (_, controller, __) {
              final double page = controller.currentPage;
              bool isEnd = page % 1 == 0 && page == 2.0;
              return Flexible(
                child: RoundedButton(
                  padding: const EdgeInsets.symmetric(horizontal: 20).copyWith(
                    top: 8,
                    bottom: 8,
                  ),
                  fullWidth: false,
                  label: isEnd ? "Get Started" : "Next",
                  onPressed: () {
                    // print('tapped $isEnd');
                    _onNext(context, controller);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<OnboardController>();
    return DotsIndicator(
      dotsCount: controller.items.length,
      position: controller.currentPage,
      decorator: DotsDecorator(
        size: const Size.square(5 * 3),
        activeSize: const Size(5 * 5, 5 * 3),
        color: Colors.grey.withOpacity(0.6),
        activeColor: primaryColor,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
