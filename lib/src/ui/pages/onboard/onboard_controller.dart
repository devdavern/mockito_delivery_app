import 'package:flutter/widgets.dart';

import '../../../data/models/onboard_item.dart';

class OnboardController extends ChangeNotifier {
  final List<OnboardItem> items = [
    OnboardItem(
      image: "assets/svg/online_groceries.svg",
      title: "Contact Us",
      description:
          "quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
    ),
    OnboardItem(
      image: "assets/svg/on_the_way.svg",
      title: "Delivery",
      description:
          "non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
    ),
    OnboardItem(
      image: "assets/svg/eating_together.svg",
      title: "Enjoy",
      description:
          "Ut placerat orci nulla pellentesque. Aliquet nec ullamcorper sit amet risus",
    )
  ];

  final PageController pageController = PageController();
  double _currentPage = 0;
  double get currentPage => _currentPage;

  void afterFirstlayout() {
    // print("afterFirstlayout ::::::: GOOD");
    pageController.addListener(() {
      final double page = pageController.page!;
      // print("PAGE ::::::: ${page.toInt()}");
      _currentPage = page;
      notifyListeners();
      // if (page % 1 == 0 && _currentPage != page) {
      //   _currentPage = page.toInt();
      //   notifyListeners();
      //   print("current page ${pageController.page}");
      // }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
