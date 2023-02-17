import '../models/notification.dart';

abstract class WebsocketRepository {
  Future<void> connect(String uri);
  Future<void> disconnect();
  // Future<void> dispose();
  Stream<AppNotification> get onNotification;
}
