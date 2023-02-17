import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'onboard_controller.dart';
import 'widgets/bottom_controls.dart';
import 'widgets/slider.dart';

class OnboardPage extends StatelessWidget {
  const OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardController>(
      create: (_) {
        final controller = OnboardController();
        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.afterFirstlayout();
        });
        return controller;
      },
      builder: (context, __) => Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  OnboardSlider(),
                  SizedBox(height: 22),
                  OnboardControls(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
