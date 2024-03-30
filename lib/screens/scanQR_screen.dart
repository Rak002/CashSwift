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

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.

  // Dropdown items for the categories
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

  // Dropdown widget
  DropdownButton<TransactionCategory> buildDropdownButton() {
    return DropdownButton<TransactionCategory>(
      value: selectedCategory,
      items: buildDropdownMenuItems(),
      onChanged: (value) {
        setState(() {
          selectedCategory = value!;
        });
      },
      hint: Text('Select'), // Optional hint text
      icon: Icon(Icons.arrow_drop_down), // Custom dropdown icon
      style: GoogleFonts.notoSans(
        textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 241, 212, 180),),
      ),
      // Custom text style
      dropdownColor: Color.fromARGB(255, 33, 33, 36),
      underline: Container(
        // Custom underline
        height: 2,
        color: Color.fromARGB(255, 241, 212, 180),
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
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
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
          idTextFieldController.text = (result?.code as String)
              .split("/")[0]; // Assign scanned data to nullable string
        }
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    print('${DateTime.now().toIso8601String()}_onPermissionSet $p');
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
      backgroundColor: Color.fromARGB(255, 26, 26, 28),
      appBar: Header(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: 670,
          child: Column(
            children: <Widget>[
              // Expanded(flex: 4, child: _buildQrView(context)),
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
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     Container(
                    //       margin: const EdgeInsets.all(8),
                    //       child: ElevatedButton(
                    //         onPressed: () async {
                    //           await controller?.pauseCamera();
                    //         },
                    //         child: Icon(Icons.pause, size: 20),
                    //       ),
                    //     ),
                    //     Container(
                    //       margin: const EdgeInsets.all(8),
                    //       child: ElevatedButton(
                    //           onPressed: () async {
                    //             await controller?.resumeCamera();
                    //           },
                    //           child: Icon(Icons.play_arrow, size: 20)),
                    //     ),
                    //     Container(
                    //       margin: const EdgeInsets.all(5),
                    //       child: ElevatedButton(
                    //           onPressed: () async {
                    //             await controller?.toggleFlash();
                    //             setState(() {});
                    //           },
                    //           child: FutureBuilder(
                    //             future: controller?.getFlashStatus(),
                    //             builder: (context, snapshot) {
                    //               if (snapshot.data != null) {
                    //                 if (snapshot.data == true) {
                    //                   return const Icon(Icons.flash_on);
                    //                 } else {
                    //                   return const Icon(Icons.flash_off);
                    //                 }
                    //               }
                    //               return Icon(Icons.flash_on);
                    //             },
                    //           )),
                    //     ),
                    //   ],
                    // ),
                    // if (result != null)
                    //   Text(
                    //       'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                    // else
                    //   const Text('Scan a code'),
                    // TextField(
                    //   controller: idTextFieldController,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Enter CashSwift ID of Receiver',
                    //     hintStyle: TextStyle(color: Colors.grey),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 15, right: 15),
                      child: TextField(
                        controller: idTextFieldController,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Color.fromARGB(255, 241, 212, 180),
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
                        cursorColor: Color.fromARGB(255, 241, 212, 180),
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
                    // TextField(
                    //   controller: amtTextFieldController,
                    //   decoration: const InputDecoration(
                    //     hintText: 'Enter Amount to Send',
                    //     hintStyle: TextStyle(color: Colors.grey),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderSide: BorderSide(color: Colors.grey),
                    //     ),
                    //   ),
                    // ),
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
                              } else if (res == "Cannot transfer money to self") {
                                showSnackBar(
                                    context, "Cannot transfer money to self", "error");
                              } else {
                                showSnackBar(
                                    context, "Some Error Occured", "error");
                                print("res :-------------------- $res");
                              }
                            }
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color.fromARGB(102, 204, 185, 255),
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
