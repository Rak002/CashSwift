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
  // String uid - we will get from firebase auth
  late double balance = -99999;
  late int phoneNumber ;
  late String cashSwiftID;
  late String username ;
  late List<dynamic> transactionsHistory = [];

  // Getter for accessing user information
  // Map<String, dynamic> get infoGetter => {
  //       'balance': balance,
  //       'phoneNumber': phoneNumber,
  //       'cashSwiftID': cashSwiftID,
  //       'transactionsHistory': transactionsHistory,
  //       'username': username,
  //     };

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
      print("Error storing user data: $e");
      return e;
    }
  }

  Future<Object> getUserData(String uid) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('Users').doc(uid).get();

      if (userData.exists) {
        if (userData.data() != null) {
          print("UserData ---------------------------------------- ${userData.data()}.");

          username = userData.data()!['username'];
          balance = userData.data()!['balance'] + 0.0;
          phoneNumber = userData.data()!['phoneNumber'] as int;
          cashSwiftID = userData.data()!['cashSwiftID'];
          transactionsHistory = userData.data()!['transactions'];

          print("Username: ${username}");
          print("Balance: $balance");
          print("Phone Number: $phoneNumber");
          print("CashSwift ID: $cashSwiftID");
          print("Transactions: $transactionsHistory");

          notifyListeners();
          return 0;
        } else {
          return "error";
        }
      }
    } catch (e) {
      print("Error retrieving user data: $e");
      return e;
    }
    return 1;
  }

  Future<Object> transferMoney(String senderUID, String receiverUID,
      double amount, TransactionCategory category) async {
    try {
      print("$senderUID , $receiverUID , $amount , $category");
      final DocumentSnapshot<Map<String, dynamic>> userData =
          await FirebaseFirestore.instance.collection('Users').doc(senderUID).get();
      late double balance ;
       if (userData.exists) {
        if (userData.data() != null) {
          print("UserData ---------------------------------------- ${userData.data()}.");
          balance = userData.data()!['balance'] + 0.0;
                if(balance < amount){
        return "insufficient balance";
      }
        } else {
          return "error";
        }
       }

      // Get a Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a timestamp for the transaction
      Timestamp timestamp = Timestamp.now();

      // Start a batch operation
      WriteBatch batch = firestore.batch();

      // Add transaction details to the 'transactions' collection
      DocumentReference transactionRef =
          firestore.collection('transactions').doc();
      batch.set(transactionRef, {
        'senderId': senderUID,
        'receiverId': receiverUID,
        'amount': amount,
        'category': category.toString().split('.').last,
        'timestamp': timestamp,
      });

      // Update sender's balance and add the transaction ID to their 'transactions' array
      DocumentReference senderDocRef =
          firestore.collection('Users').doc(senderUID);
      batch.update(senderDocRef, {
        'balance': FieldValue.increment(-amount),
        'transactions': FieldValue.arrayUnion([transactionRef.id]),
      });

      // Update receiver's balance and add the transaction ID to their 'transactions' array
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
      print("Error transferring money: $e");
      return e;
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionHistory(String uid) async {
    try {
      // Get Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the user document
      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(uid).get();

      // Check if the user document exists
      if (!userDoc.exists) {
        // User not found, return an empty list
        return [];
      }

      // Get the list of transaction IDs from the user document
      List<dynamic> transactionIds = userDoc.get('transactions');

      // Fetch details of each transaction
      List<Map<String, dynamic>> transactionHistory = [];

      for (String transactionId in transactionIds) {
        // Get the transaction document
        DocumentSnapshot transactionDoc =
            await firestore.collection('transactions').doc(transactionId).get();

        if (transactionDoc.exists) {
          // Add transaction details to the list
          transactionHistory.add(transactionDoc.data() as Map<String, dynamic>);
        }
      }

      return transactionHistory;
    } catch (e) {
      print("Error fetching transaction history: $e");
      // Handle error
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getTransactionHistoryofCategory(
      String uid, TransactionCategory category) async {
    try {
      // Get Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the user document
      DocumentSnapshot userDoc =
          await firestore.collection('Users').doc(uid).get();

      // Check if the user document exists
      if (!userDoc.exists) {
        // User not found, return an empty list
        return [];
      }

      // Get the list of transaction IDs from the user document
      List<dynamic> transactionIds = userDoc.get('transactions');

      // Fetch details of transactions of the specified category
      List<Map<String, dynamic>> transactionHistory = [];

      for (String transactionId in transactionIds) {
        // Get the transaction document
        DocumentSnapshot transactionDoc =
            await firestore.collection('transactions').doc(transactionId).get();

        if (transactionDoc.exists) {
          // Check if the transaction belongs to the specified category
          String transactionCategory = transactionDoc.get('category');

          if (transactionCategory == category.toString().split('.').last) {
            // Add transaction details to the list
            transactionHistory
                .add(transactionDoc.data() as Map<String, dynamic>);
          }
        }
      }

      return transactionHistory;
    } catch (e) {
      print("Error fetching transaction history: $e");
      // Handle error
      return [];
    }
  }
}
