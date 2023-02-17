import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../utils/colors.dart';
import '../../../../utils/font_styles.dart';
import '../../../global_controllers/my_cart_controller.dart';

class CheckOutPreview extends StatelessWidget {
  const CheckOutPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MyCartController>();
    if (!controller.hasItems) return Container(height: 0);

    return Container(
      decoration: const BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
          .copyWith(top: 16),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Table(
                children: [
                  _buildTableRow("Subtotal", " ${controller.subtotal}"),
                  _buildTableRow("Tax & fee", " ${controller.taxAndFee}"),
                  _buildTableRow("Delivery", " ${controller.delivery}"),
                  _buildTableRow("Total", " ${controller.total}"),
                ],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: CupertinoButton(
                onPressed: () {},
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "CHECKOUT",
                    style: MyFontStyles.button.copyWith(fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Text(
          label,
          style: MyFontStyles.subSubtitle.copyWith(
            color: Colors.white,
            fontSize: 18,
            letterSpacing: 0.7,
          ),
        ),
        RichText(
          textAlign: TextAlign.right,
          text: TextSpan(
            text: "\$",
            style: MyFontStyles.subtitleColor.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
            children: [
              TextSpan(
                text: value,
                style: MyFontStyles.title.copyWith(
                  color: Colors.white,
                  fontSize: 16.5,
                  letterSpacing: 0.7,
                ),
              ),
            ],
          ),
        ),
        // Text(
        //   value,
        //   style: MyFontStyles.subtitleColor.copyWith(
        //     color: Colors.white,
        //     fontSize: 20,
        //     letterSpacing: 0.7,
        //   ),
        //   textAlign: TextAlign.right,
        // ),
      ],
    );
  }
}
