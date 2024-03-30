import 'dart:async';
import 'dart:ui';

import 'package:cashswift/models/data_model.dart';
import 'package:cashswift/modules/ui_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
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
      backgroundColor: Color.fromARGB(255, 26, 26, 28),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(top : 40),
              child: Container(
                width: 300,
                height: 300,
                alignment: Alignment.center,
                color: Colors.white,
                child: CustomPaint(
                    size: const Size.square(280),
                    painter: QrPainter(
                      data: "${Provider.of<DataModel>(context, listen: false).cashSwiftID}/${FirebaseAuth.instance.currentUser?.uid}",
                      version: QrVersions.auto,
                      eyeStyle: const QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      dataModuleStyle: const QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      // size: 320.0,
                      embeddedImageStyle: const QrEmbeddedImageStyle(
                        size: Size.square(60),
                      ),
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Footer(),
    );
  }
}