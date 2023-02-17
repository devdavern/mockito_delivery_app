import '../models/notification.dart';
import '../providers/remote/websocket_provider.dart';
import '../repositories/websocket_repository.dart';

class WebsocketRepositoryImpl implements WebsocketRepository {
  final WebsocketProvider _provider;

  WebsocketRepositoryImpl(this._provider);

  @override
  Future<void> connect(String uri) {
    return _provider.connect(uri);
  }

  @override
  Stream<AppNotification> get onNotification => _provider.onNotification;

  @override
  Future<void> disconnect() {
    return _provider.disconnect();
  }

  // @override
  // Future<void> dispose() {
  //   return _provider.dispose();
  // }
}
