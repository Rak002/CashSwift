import 'package:cashswift/screens/home_screen.dart';
import 'package:cashswift/screens/receive_screen.dart';
import 'package:cashswift/screens/scanQR_screen.dart';
import 'package:flutter/material.dart';
import "package:cashswift/screens/user_screen.dart";
import 'package:google_fonts/google_fonts.dart';

AppBar Header(BuildContext context) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor:  Color.fromARGB(255, 46, 15, 99),
    toolbarHeight: 70,
    title: Padding(
        padding: const EdgeInsets.only(
          left: 0,
          right: 0,
          top: 60,
          bottom: 60,
        ),
        child: Container(
            height: 50,
            child: Image.asset('lib/images/fixed_images/logo1.png'))),
    actions: [
      InkWell(
        onTap: () {
          // navigate to notification page
        },
        splashColor: Colors.transparent,
        child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 20,
              bottom: 10,
            ),
            child: Container(
                width: 50,
                child:
                    Icon(Icons.notifications_active, color: Colors.white, size: 30))),
      ),
      InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) {
            return const UserScreen();
          }));
        },
        splashColor: Colors.transparent,
        child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 15,
              top: 20,
              bottom: 10,
            ),
            child: Container(
                width: 50,
                child:
                    Icon(Icons.account_circle, color: Colors.white, size: 30))),
      ),
    ],
  );
}


class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        color:  Color.fromARGB(255, 46, 15, 99),
        child: Row(
          children: [
            // Home Button
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const HomeScreen();
                  }));
                },
                splashColor: Colors.transparent,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                        width: 50,
                        child: const Icon(Icons.home
                        , color: Colors.white, size: 30))),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const ScanQRScreen();
                  }));
                },
                splashColor: Colors.transparent,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                        width: 50,
                        child: const Icon(Icons.qr_code_scanner, color: Colors.white, size: 30))),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return const ReceiveScreen();
                  }));
                },
                splashColor: Colors.transparent,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                        width: 50,
                        child: const Icon(Icons.download, color: Colors.white, size: 30))),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () {
                  // navigate to transaction history page
                },
                splashColor: Colors.transparent,
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      top: 10,
                      bottom: 10,
                    ),
                    child: Container(
                        width: 50,
                        child: const Icon(Icons.payment, color: Colors.white, size: 30))),
              ),
            ),
          ],
        ));
  }
}

void showSnackBar(BuildContext context, String text, String type) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: (type == "error")
          ? Color.fromARGB(255, 255, 103, 92)
          : Color.fromARGB(255, 75, 165, 78),
      content: Text(text,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
      duration:
          const Duration(seconds: 3), // Duration for which snackbar is visible
      action: SnackBarAction(
        label: 'Close', // Label for the action
        textColor: Color.fromARGB(255, 219, 230, 255),
        onPressed: () {
          // Action when pressed
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    ),
  );
}