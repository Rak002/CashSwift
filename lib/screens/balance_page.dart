import 'package:cashswift/models/data_model.dart';
import 'package:cashswift/modules/ui_components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BalancePage extends StatefulWidget {
  const BalancePage({super.key});

  @override
  State<BalancePage> createState() => _BalancePageState();
}

class _BalancePageState extends State<BalancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      backgroundColor: Color.fromARGB(255, 26, 26, 28),
      body: Column(  mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(20.0), // Adjust the value as needed
                    color: Color.fromARGB(26, 255, 255, 255),
                  ),
                  width: 600,
                  height: 75,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "   Balance : ",
                          style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        ),
                        Text(
                          " ${Provider.of<DataModel>(context, listen: false).balance}   ",
                          style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ],),
      bottomNavigationBar: Footer(),
    );
  }
}