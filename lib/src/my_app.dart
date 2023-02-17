import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'helpers/dependency_injections.dart';
import 'routes/pages.dart';
import 'ui/global_controllers/my_cart_controller.dart';
import 'utils/colors.dart';
import 'utils/font_styles.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    DependencyInjections.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MyCartController(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: const MaterialColor(
            0xffffecb3,
            {
              50: Color(0xffffb74d),
              100: Color(0xffffb74d),
              200: Color(0xffffb74d),
              300: Color(0xffffb74d),
              400: Color(0xffffb74d),
              500: Color(0xffffb74d),
              600: Color(0xffffb74d),
              700: Color(0xffffb74d),
              800: Color(0xffffb74d),
              900: Color(0xffffb74d),
            },
          ),
          primaryColor: primaryColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: MyFontStyles.textTheme,
          cupertinoOverrideTheme: CupertinoThemeData(
            primaryColor: primaryColor,
            textTheme: CupertinoTextThemeData(
              textStyle: MyFontStyles.button,
            ),
          ),
        ),
        initialRoute: Pages.initial,
        routes: Pages.routes,
      ),
    );
  }
}
