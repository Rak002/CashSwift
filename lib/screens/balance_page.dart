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
  List<Map<String, dynamic>> _transactionHistory = [];

  @override
  void initState() {
    super.initState();
    _fetchTransactionHistory();
  }

  Future<void> _fetchTransactionHistory() async {
    String uid = Provider.of<DataModel>(context, listen: false)
        .cashSwiftID
        .split('@')[0];
    List<Map<String, dynamic>> transactions =
        await DataModel().getTransactionHistory(uid);
    setState(() {
      _transactionHistory = transactions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context),
      backgroundColor: const Color.fromARGB(255, 26, 26, 28),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: const Color.fromARGB(255, 76, 38, 140),
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
                  " Transaction History ",
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
          Expanded(
            child: ListView.builder(
              itemCount: _transactionHistory.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> transaction = _transactionHistory[index];
                return Padding(
                  padding: const EdgeInsets.only(
                      left: 18, right: 18, top: 10, bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: const Color.fromARGB(26, 255, 255, 255),
                    ),
                    width: 600,
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 60,
                          child: (transaction['receiverId'].toString() ==
                                  Provider.of<DataModel>(context, listen: false)
                                      .cashSwiftID
                                      .split('@')[0])
                              ? Transform.rotate(
                                  angle: -45 * (3.14 / 180),
                                  child: const Icon(Icons.arrow_downward,
                                      color: Colors.green, size: 30))
                              : Transform.rotate(
                                  angle: -45 * (3.14 / 180),
                                  child: const Icon(Icons.arrow_upward,
                                      color: Color.fromARGB(255, 175, 76, 76),
                                      size: 30)),
                        ),
                        Container(
                          width: 200,
                          height: 60,
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              transaction['category'].toString(),
                              style: GoogleFonts.notoSans(
                                textStyle: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(
                          transaction['amount'].toString(),
                          style: GoogleFonts.notoSans(
                            textStyle: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
