

import 'package:cashswift/modules/ui_components.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      backgroundColor: Color.fromARGB(255, 26, 26, 28),
      body: Column(),
      bottomNavigationBar: Footer(),
    );
  }
}
