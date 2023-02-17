import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/models/notification.dart';
import '../../data/repositories/websocket_repository.dart';
import '../../helpers/get.dart';

class NotificationsController extends ChangeNotifier {
  final _wsRepostory = Get.i.find<WebsocketRepository>(lazy: true);

  late StreamSubscription _subscription;
  List<AppNotification> _notifications = [];
  List<AppNotification> get notifications => _notifications;
  final StreamController<List<AppNotification>> _notificationsStreamController =
      StreamController.broadcast();
  Stream<List<AppNotification>> get onNotificationsChanged =>
      _notificationsStreamController.stream;

  NotificationsController() {
    // ignore: avoid_print
    // print("🥶");
    _subscription = _wsRepostory.onNotification.listen(_onNotificationListener);
  }

  void _onNotificationListener(AppNotification notification) {
    // ignore: avoid_print
    // print("👀");
    _notifications = [notification, ...notifications];
    _notificationsStreamController.sink.add(_notifications);
    notifyListeners();
  }

  void clear() {
    _notifications = [];
  }

  @override
  void dispose() {
    _notificationsStreamController.close();
    _subscription.cancel();
    super.dispose();
  }
}
