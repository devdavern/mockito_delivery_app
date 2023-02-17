import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../../data/models/category.dart';
import '../../../../../../utils/app/app_utils.dart';
import '../../../../../../utils/colors.dart';
import '../../../../../../utils/font_styles.dart';
import '../home_tab_controller.dart';

class CategoriesMenu extends StatelessWidget {
  const CategoriesMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeTabController>(context, listen: false);
    return SizedBox(
      height: 122,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(
          controller.categories.length,
          (index) {
            final Category category = controller.categories[index];
            return CategoryButton(
              category: category,
              isFirst: index == 0,
            );
          },
        ),
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    Key? key,
    required this.category,
    required this.isFirst,
  }) : super(key: key);

  final Category category;
  final bool isFirst;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 6,
        left: isFirst ? 10 : 6,
        bottom: 10,
        top: 0,
      ),
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xfffafafa),
            border: Border.all(
              width: 4,
              color: primaryColor,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0xffffecb3),
                blurRadius: 0,
                offset: Offset(
                  6,
                  6,
                ),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: AppUtils.isHtml
                    ? Image.network(
                        category.iconPath,
                        width: 75,
                      )
                    : SvgPicture.asset(
                        category.iconPath,
                        width: 75,
                      ),
              ),
              const SizedBox(height: 10),
              Text(
                category.label,
                style: MyFontStyles.subSubtitle.copyWith(
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
