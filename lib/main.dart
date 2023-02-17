import 'package:flutter/material.dart';

import 'src/helpers/dependency_injections.dart';
import 'src/my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjections.initialize();
  runApp(
    const MyApp(),
  );
}
