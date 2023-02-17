import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../utils/app/app_utils.dart';
import '../../../../../../utils/font_styles.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: CupertinoButton(
        padding: const EdgeInsets.all(4),
        color: const Color(0xffefebe9),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppUtils.isHtml
                  ? Image.network(
                      'assets/svg/search.svg',
                      width: 22,
                      color: Colors.grey,
                    )
                  : SvgPicture.asset(
                      'assets/svg/search.svg',
                      width: 22,
                      color: Colors.grey,
                    ),
              const SizedBox(width: 10),
              Text(
                "Find your food",
                style: MyFontStyles.subSubtitle,
              )
            ],
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
