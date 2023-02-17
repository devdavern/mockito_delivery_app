import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../global_controllers/notifications_controller.dart';
import 'notifications_item.dart';

class NotificationsTab extends StatefulWidget {
  const NotificationsTab({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NotificationsTabState createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<NotificationsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<NotificationsController>();
    final notifications = controller.notifications;

    super.build(context);
    return ListView.builder(
      itemBuilder: (_, index) {
        final notification = notifications[index];
        return NotificationItem(notification: notification);
      },
      itemCount: notifications.length,
    );
  }

  @override
  bool get wantKeepAlive => true;
}
