import 'dart:async';

import 'package:mockito_delivery_app/src/data/repositories/websocket_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../../data/models/dish.dart';
import '../../../helpers/get.dart';
import '../../global_controllers/notifications_controller.dart';

class HomeController extends ChangeNotifier implements TickerProvider {
  final NotificationsController notificationsController;
  HomeController(this.notificationsController) {
    _init();
  }

  // final TabController tabController = TabController(
  //   length: 4,
  //   vsync: NavigatorState(),
  // );

  final _wsRepository = Get.i.find<WebsocketRepository>(lazy: true);

  int _currentPage = 0;
  int get currentPage => _currentPage;

  Map<int, Dish> _favorites = {};
  Map<int, Dish> get favorites => _favorites;

  @visibleForTesting
  bool disposed = false;
  bool isFavorite(Dish dish) => _favorites.containsKey(dish.id);

  late TabController tabController;

  void Function()? onDispose;

  void _init() {
    tabController = TabController(
      vsync: this,
      length: 4,
    );
  }

  StreamSubscription? _notificationsSubscription;

  List<BottomBarItem> _menuItems = [
    BottomBarItem(
      icon: 'assets/svg/home.svg',
      label: 'Home',
    ),
    BottomBarItem(
      icon: 'assets/svg/favorite.svg',
      label: 'Favorites',
    ),
    BottomBarItem(
      icon: 'assets/svg/bell.svg',
      label: 'Notifications',
    ),
    BottomBarItem(
      icon: 'assets/svg/avatar.svg',
      label: 'More',
    )
  ];

  List<BottomBarItem> get menuItems => _menuItems;

  void afterFirstLayout() {
    _wsRepository.connect("https://websocket.demo");
    _notificationsSubscription =
        notificationsController.onNotificationsChanged.listen((notifications) {
      final int count = notifications.length;
      List<BottomBarItem> copy = [..._menuItems];
      copy[2] = copy[2].copyWith(
        badgeCount: count,
      );
      _menuItems = copy;
      notifyListeners();
    });

    tabController.addListener(() {
      _currentPage = tabController.index;
      notifyListeners();
    });
  }

  void toggleFavorite(Dish dish) {
    Map<int, Dish> copy = Map<int, Dish>.from(_favorites);
    if (isFavorite(dish)) {
      copy.remove(dish.id);
    } else {
      copy[dish.id] = dish;
    }
    _favorites = copy;
    notifyListeners();
  }

  void deleteFavorite(Dish dish) {
    Map<int, Dish> copy = Map<int, Dish>.from(_favorites);
    if (isFavorite(dish)) {
      copy.remove(dish.id);
      _favorites = copy;
      notifyListeners();
    }
  }

  @override
  Future<void> dispose() async {
    await _notificationsSubscription?.cancel();
    tabController.dispose();
    if (onDispose != null) {
      onDispose!();
    }

    await _wsRepository.disconnect();
    disposed = true;
    super.dispose();
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

class BottomBarItem {
  final String icon, label;
  final int badgeCount;

  BottomBarItem({
    required this.icon,
    required this.label,
    this.badgeCount = 0,
  });

  BottomBarItem copyWith({
    String? icon,
    String? label,
    int? badgeCount,
  }) {
    return BottomBarItem(
      icon: icon ?? this.icon,
      label: label ?? this.label,
      badgeCount: badgeCount ?? this.badgeCount,
    );
  }
}
