import 'package:mockito_delivery_app/src/data/models/dish.dart';
import 'package:mockito_delivery_app/src/data/providers/remote/food_menu_provider.dart';

class MockFoodMenuProvider implements FoodMenuProvider {
  @override
  Future<List<Dish>> getPopularMenu() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return [
      Dish(
        id: 1,
        name: "",
        photo: "",
        price: 9.99,
        rate: null,
        description: "",
      ),
    ];
  }
}
