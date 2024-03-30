import 'dart:io';

import 'package:cashswift/models/data_model.dart';
import 'package:cashswift/modules/ui_components.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRScreen extends StatefulWidget {
  const ScanQRScreen({super.key});

  @override
  State<ScanQRScreen> createState() => _ScanQRScreenState();
}

class _ScanQRScreenState extends State<ScanQRScreen> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  TextEditingController idTextFieldController = TextEditingController();
  TextEditingController amtTextFieldController = TextEditingController();
  TransactionCategory selectedCategory = TransactionCategory.Groceries;

  List<DropdownMenuItem<TransactionCategory>> buildDropdownMenuItems() {
    List<DropdownMenuItem<TransactionCategory>> items = [];
    for (TransactionCategory category in TransactionCategory.values) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(category.toString().split('.').last),
        ),
      );
    }
    return items;
  }

  DropdownButton<TransactionCategory> buildDropdownButton() {
    return DropdownButton<TransactionCategory>(
      value: selectedCategory,
      items: buildDropdownMenuItems(),
      onChanged: (value) {
        setState(() {
          selectedCategory = value!;
        });
      },
      hint: const Text('Select'),
      icon: const Icon(Icons.arrow_drop_down),
      style: GoogleFonts.notoSans(
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 241, 212, 180),
        ),
      ),
      dropdownColor: const Color.fromARGB(255, 33, 33, 36),
      underline: Container(
        height: 2,
        color: const Color.fromARGB(255, 241, 212, 180),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    idTextFieldController = TextEditingController();
    amtTextFieldController = TextEditingController();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (result != null) {
          idTextFieldController.text = (result?.code as String).split("/")[0];
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    // print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 26, 26, 28),
      appBar: Header(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 670,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 320,
                child: _buildQrView(context),
              ),
              Container(
                height: 350,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 15),
                      child: TextField(
                        controller: idTextFieldController,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: const Color.fromARGB(255, 241, 212, 180),
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 241, 212, 180)),
                        ),
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 241, 212, 180),
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 241, 212, 180),
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Enter CashSwift ID of Receiver',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(160, 241, 212, 180),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0, bottom: 10, left: 15, right: 15),
                      child: TextField(
                        controller: amtTextFieldController,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: const Color.fromARGB(255, 241, 212, 180),
                        style: GoogleFonts.notoSans(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 241, 212, 180)),
                        ),
                        decoration: const InputDecoration(
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 241, 212, 180),
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color.fromARGB(255, 241, 212, 180),
                              width: 1.0,
                            ),
                          ),
                          hintText: 'Enter Amount to Send',
                          hintStyle: TextStyle(
                            color: Color.fromARGB(160, 241, 212, 180),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Select Category:    ',
                            style: GoogleFonts.notoSans(
                              textStyle: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                          buildDropdownButton(),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: OutlinedButton(
                        onPressed: () async {
                          final user = FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            if (user.emailVerified) {
                              Object res = await DataModel().transferMoney(
                                  user.uid,
                                  idTextFieldController.text.split("@")[0],
                                  double.parse(
                                    amtTextFieldController.text,
                                  ),
                                  selectedCategory);
                              if (res == 0) {
                                showSnackBar(context, "Money Send Successfully",
                                    "Success");
                              } else if (res == "insufficient balance") {
                                showSnackBar(
                                    context, "Insufficient Balance", "error");
                              } else if (res ==
                                  "Cannot transfer money to self") {
                                showSnackBar(context,
                                    "Cannot transfer money to self", "error");
                              } else {
                                showSnackBar(
                                    context, "Some Error Occured", "error");
                              }
                            }
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(102, 204, 185, 255),
                          side: const BorderSide(
                              width: 3.0,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                        child: Text(
                          'Send',
                          style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255)),
                          ),
                        ),
                      ),
                    ),
                  ],
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
