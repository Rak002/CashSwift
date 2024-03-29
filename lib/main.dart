import 'package:flutter/material.dart';
import 'package:cashswift/models/data_model.dart';
import 'package:provider/provider.dart';
import 'package:cashswift/screens/intro_screen.dart';
import 'package:flutter/gestures.dart';

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataModel(),
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        debugShowCheckedModeBanner: false,
        title: 'CashSwift',
        home: IntroScreen(),
      ),
    );
  }
}
