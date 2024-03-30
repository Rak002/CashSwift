import 'dart:async';
import 'dart:ui';

import 'package:cashswift/models/data_model.dart';
import 'package:cashswift/modules/ui_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class ReceiveScreen extends StatefulWidget {
  const ReceiveScreen({super.key});

  @override
  State<ReceiveScreen> createState() => _ReceiveScreenState();
}

class _ReceiveScreenState extends State<ReceiveScreen> {
  Future<ui.Image> _loadOverlayImage() async {
    final Completer<ui.Image> completer = Completer<ui.Image>();
    final ByteData byteData =
        await rootBundle.load('assets/images/4.0x/logo_yakka.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      backgroundColor: const Color.fromARGB(255, 26, 26, 28),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  width: 300,
                  height: 300,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: CustomPaint(
                    size: const Size.square(280),
                    painter: QrPainter(
                      data:
                          "${Provider.of<DataModel>(context, listen: false).cashSwiftID}/${FirebaseAuth.instance.currentUser?.uid}",
                      version: QrVersions.auto,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      embeddedImageStyle: const QrEmbeddedImageStyle(
                        size: Size.square(60),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Scan to Receive",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80,
                      height: 2,
                      color: Colors.white,
                    ),
                    const Text(
                      "   or   ",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Container(
                      width: 80,
                      height: 2,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: const Color.fromARGB(26, 255, 255, 255),
                  ),
                  width: 600,
                  height: 140,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(
                                top: 13.0,
                                bottom: 10.0,
                                left: 20.0,
                                right: 20.0),
                            child: Text(
                              "Use CashSwift ID",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(
                                  text: Provider.of<DataModel>(context,
                                          listen: false)
                                      .cashSwiftID,
                                ));
                              },
                              icon: const Icon(Icons.copy, color: Colors.white))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          Provider.of<DataModel>(context, listen: false)
                              .cashSwiftID,
                          style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 241, 212, 180),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
