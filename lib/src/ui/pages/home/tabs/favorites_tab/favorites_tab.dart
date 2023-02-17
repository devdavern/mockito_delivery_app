import 'package:mockito_delivery_app/src/ui/global_widgets/circular_animation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../data/models/dish.dart';
import '../../home_controller.dart';
import 'favorites_item.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final favorites = context
        .select<HomeController, Map<int, Dish>>(
          (_) => _.favorites,
        )
        .values
        .toList();

    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: 140,
          left: 10,
          right: 10,
          bottom: 144,
          child: Opacity(
            opacity: 0.6,
            child: Container(
              color: Colors.orange.shade100,
              child: Center(
                child: CircularAnimation(
                  grados: 90,
                ),
              ),
            ),
          ),
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemBuilder: (_, index) => FavoriteItem(
            dish: favorites[index],
          ),
          itemCount: favorites.length,
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
