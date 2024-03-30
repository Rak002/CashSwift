import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum TransactionCategory {
  Groceries,
  Bills,
  Entertainment,
  Dining,
  Shopping,
  Transportation,
  Health,
  Education,
  Other,
}

class DataModel extends ChangeNotifier {
  late double balance = -99999;
  late int phoneNumber ;
  late String cashSwiftID;
  late String username ;
  late List<dynamic> transactionsHistory = [];

  get infoGetter {
    balance;
    phoneNumber;
    cashSwiftID;
    transactionsHistory;
    username;
  }

  Future<Object> storeUserData(
      String uid, String email, double balance, int phoneNumber) async {
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'username': email.split('@')[0],
        'balance': balance,
        'cashSwiftID': "$uid@cashswift.com",
        'phoneNumber': phoneNumber,
        'transactions': [],
      });

      return 0;
    } catch (e) {
      return e;
    }
  }

  Future<Object> getUserData(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (userData.exists) {
        if (userData.data() != null) {


          username = userData.data()!['username'];
          balance = userData.data()!['balance'] + 0.0;
          phoneNumber = userData.data()!['phoneNumber'] as int;
          cashSwiftID = userData.data()!['cashSwiftID'];
          transactionsHistory = userData.data()!['transactions'];

          notifyListeners();
          return 0;
        } else {
          return "error";
        }
      }
    } catch (e) {
      return e;
    }
    return 1;
  }

  Future<Object> transferMoney(String senderUID, String receiverUID,
      double amount, TransactionCategory category) async {
    try {
      if(senderUID == receiverUID){
        return "Cannot transfer money to self";
      }
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('Users').doc(senderUID).get();
      late double balance ;
       if (userData.exists) {
        if (userData.data() != null) {
          balance = userData.data()!['balance'] + 0.0;
                if(balance < amount){
        return "insufficient balance";
      }
        } else {
          return "error";
        }
       }

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      Timestamp timestamp = Timestamp.now();

      WriteBatch batch = firestore.batch();

      DocumentReference transactionRef =
          firestore.collection('transactions').doc();
      batch.set(transactionRef, {
        'senderId': senderUID,
        'receiverId': receiverUID,
        'amount': amount,
        'category': category.toString().split('.').last,
        'timestamp': timestamp,
      });

      DocumentReference senderDocRef =
          firestore.collection('Users').doc(senderUID);
      batch.update(senderDocRef, {
        'balance': FieldValue.increment(-amount),
        'transactions': FieldValue.arrayUnion([transactionRef.id]),
      });

      DocumentReference receiverDocRef =
          firestore.collection('Users').doc(receiverUID);
      batch.update(receiverDocRef, {
        'balance': FieldValue.increment(amount),
        'transactions': FieldValue.arrayUnion([transactionRef.id]),
      });
      await batch.commit();
      getUserData(senderUID);

      return 0;
    } catch (e) {
      return e;
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionHistory(String uid) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(uid).get();

      if (!userDoc.exists) {
        return [];
      }

      List<dynamic> transactionIds = userDoc.get('transactions');

      List<Map<String, dynamic>> transactionHistory = [];

      for (String transactionId in transactionIds) {
        DocumentSnapshot transactionDoc =
            await firestore.collection('transactions').doc(transactionId).get();

        if (transactionDoc.exists) {
          transactionHistory.add(transactionDoc.data() as Map<String, dynamic>);
        }
      }

      return transactionHistory;
    } catch (e) {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionHistoryofCategory(
      String uid, TransactionCategory category) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(uid).get();

      if (!userDoc.exists) {
        return [];
      }

      List<dynamic> transactionIds = userDoc.get('transactions');

      List<Map<String, dynamic>> transactionHistory = [];

      for (String transactionId in transactionIds) {
        DocumentSnapshot transactionDoc =
            await firestore.collection('transactions').doc(transactionId).get();

        if (transactionDoc.exists) {
          String transactionCategory = transactionDoc.get('category');

          if (transactionCategory == category.toString().split('.').last) {
            transactionHistory
                .add(transactionDoc.data() as Map<String, dynamic>);
          }
        }
      }

      return transactionHistory;
    } catch (e) {
      return [];
    }
  }
}
