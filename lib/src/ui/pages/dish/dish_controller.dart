import 'package:flutter/widgets.dart';

import '../../../data/models/dish.dart';

class DishPageArguments {
  final String tag;
  final Dish dish;

  DishPageArguments({
    required this.tag,
    required this.dish,
  });
}

class DishController extends ChangeNotifier {
  VoidCallback? onDispose;
  String tag;
  Dish dish;
  bool _isFavorite;
  bool get isFavorite => _isFavorite;
  DishController(DishPageArguments arguments, this._isFavorite)
      : dish = arguments.dish,
        tag = arguments.tag;

  void onCounterChanged(int counter) {
    dish = dish.updateCounter(counter);
  }

  void toggleFavorite() {
    _isFavorite = !_isFavorite;
    notifyListeners();
  }

  @override
  void dispose() {
    if (onDispose != null) {
      onDispose!();
    }
    super.dispose();
  }
}
