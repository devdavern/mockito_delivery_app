import 'package:mockito_delivery_app/src/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../data/models/onboard_item.dart';
import '../../../../utils/app/app_utils.dart';
import '../onboard_controller.dart';
import '../../../../utils/font_styles.dart';

class OnboardSlider extends StatelessWidget {
  const OnboardSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<OnboardController>(context, listen: false);

    return Flexible(
      child: PageView(
        controller: controller.pageController,
        children: List.generate(
          controller.items.length,
          (index) {
            final OnboardItem item = controller.items[index];
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 5,
                  color: Colors.white,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xfffff3e0),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 5 * 3,
                    color: primaryColor.withOpacity(0.91),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppUtils.isHtml
                            ? Image.network(
                                item.image,
                                width: 44 * 8,
                              )
                            : SvgPicture.asset(
                                item.image,
                                width: 44 * 8,
                              ),
                      ),
                      Flexible(
                        child: Text(
                          item.title,
                          textAlign: TextAlign.center,
                          style: MyFontStyles.title.copyWith(fontSize: 40 - 4),
                        ),
                      ),
                      Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: MyFontStyles.normal,
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
