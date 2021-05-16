import 'package:flutter/material.dart';
import 'package:randomizer/ui/home.screen.dart';
import 'package:randomizer/utils/constants/color.const.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: COLOR_PRODUCT,
          accentColor: COLOR_PRODUCT,
          appBarTheme: AppBarTheme(elevation: 0.0),
        ),
        home: HomeScreen(),
      );
}
