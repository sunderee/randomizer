import 'package:flutter/material.dart';
import 'package:randomizer/ui/main.screen.dart';
import 'package:randomizer/utils/constants/color.const.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: colorProduct,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(elevation: 0.0),
      ),
      home: const MainScreen(),
    );
  }
}
