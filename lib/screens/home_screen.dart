import 'package:cashswift/modules/ui_components.dart';
import 'package:cashswift/screens/balance_page.dart';
import 'package:cashswift/screens/receive_screen.dart';
import 'package:cashswift/screens/scanQR_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color.fromARGB(255, 26, 26, 28),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              splashColor: const Color.fromARGB(58, 255, 255, 255),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ScanQRScreen();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromARGB(26, 255, 255, 255),
                ),
                width: 600,
                height: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.qr_code, color: Colors.white, size: 50),
                    Text(
                      "Send Money  ",
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 25,
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              splashColor: const Color.fromARGB(58, 255, 255, 255),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const ReceiveScreen();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromARGB(26, 255, 255, 255),
                ),
                width: 600,
                height: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.payment, color: Colors.white, size: 50),
                    Text(
                      "Receive Money",
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 25,
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
          Padding(
            padding: const EdgeInsets.all(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              splashColor: const Color.fromARGB(58, 255, 255, 255),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const BalancePage();
                }));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: const Color.fromARGB(26, 255, 255, 255),
                ),
                width: 600,
                height: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Icon(Icons.wallet, color: Colors.white, size: 50),
                    Text(
                      "Check Balance  ",
                      style: GoogleFonts.notoSans(
                        textStyle: const TextStyle(
                          fontSize: 25,
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
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
