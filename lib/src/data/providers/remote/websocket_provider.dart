import 'dart:async';
import 'package:faker/faker.dart';

import '../../models/notification.dart';

class WebsocketProvider {
  WebsocketProvider() {
    // print('WebsocketProvider::::::::::::::::::');
  }

  Future<void> connect(String uri) async {
    await Future.delayed(const Duration(milliseconds: 2000));
    _init();
  }

  final StreamController<AppNotification> _controller =
      StreamController.broadcast();

  Stream<AppNotification> get onNotification => _controller.stream;

  Timer? _timer;

  _init() {
    _timer = Timer.periodic(
      const Duration(milliseconds: 2000),
      (_) {
        final faker = Faker();
        final notification = AppNotification(
          id: DateTime.now().microsecondsSinceEpoch,
          title: '${faker.lorem.word()} ${faker.lorem.word()}',
          description: faker.lorem.sentence(),
          content: {},
          createdAt: DateTime.now(),
        );
        _controller.sink.add(notification);
      },
    );
  }

  Future<void> disconnect() async {
    _timer?.cancel();
    await _controller.close();
    await Future.delayed(const Duration(milliseconds: 2000));
  }
}
