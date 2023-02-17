import 'dart:async';

import 'package:mockito_delivery_app/src/data/models/notification.dart';
import 'package:mockito_delivery_app/src/data/providers/remote/websocket_provider.dart';
import 'package:faker/faker.dart';

class MockWebsocketProvider implements WebsocketProvider {
  final int? delay;

  final StreamController<AppNotification> _controller =
      StreamController.broadcast();

  MockWebsocketProvider([this.delay]);

  @override
  Future<void> connect(String uri) async {
    await Future.delayed(Duration(milliseconds: delay ?? 0));
    _init();
  }

  void _init() {
    final faker = Faker();
    final notification = AppNotification(
      id: DateTime.now().millisecondsSinceEpoch,
      title: "${faker.lorem.word()} ${faker.lorem.word()}",
      description: faker.lorem.sentence(),
      content: {},
      createdAt: DateTime.now(),
    );
    _controller.sink.add(notification);
  }

  @override
  Future<void> disconnect() async {
    await _controller.close();
  }

  @override
  Stream<AppNotification> get onNotification => _controller.stream;
}
