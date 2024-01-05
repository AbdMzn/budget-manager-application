import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});
  var logger = Logger();
  bool walletExists = false;

  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> updateUserData(String uid) async {
    return await usersCollection.doc(uid).set({
      'uid': uid,
    });
  }

  Future<bool> createNewWallet(String walletName, double balance) async {
    try {
      DocumentReference document =
          FirebaseFirestore.instance.collection('users').doc(uid);

      await document.update({
        'selected_wallet': walletName,
      });
      await document.update({
        'user_wallets': FieldValue.arrayUnion([walletName]),
      });

      await document.collection('wallets').doc(walletName).set({
        'wallet_name': walletName,
        'balance': balance,
      });

      return true;
    } catch (error) {
      logger.e('Error creating wallet: $error');
      return false;
    }
  }

  Future<bool> selectWallet(String walletName) async {
    try {
      var document = FirebaseFirestore.instance.collection('users').doc(uid);
      await document.update({
        'selected_wallet': walletName,
      });
      return true;
    } catch (error) {
      logger.e('Error selecting wallet: $error');
      return false;
    }
  }

  static Future<bool> doesWalletsExist(String uid) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .limit(1)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      Logger logger = Logger();
      logger.e("Error checking collection existence: $e");
      return false;
    }
  }

  Future<List<String>?> walletList() async {
    try {
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('users').doc(uid);

      DocumentSnapshot document = await documentReference.get();
      if (document.exists) {
        List<String> value = (document['user_wallets'] as List<dynamic>)
            .map((dynamic item) => item.toString())
            .toList();
        logger.i('Wallet list: $value');
        return value;
      } else {
        logger.e('User has no wallets');
        return null;
      }
    } catch (e) {
      logger.e('Error: $e');
      return null;
    }
  }

  Future<bool> newTransaction(String walletName, String? title, double value,
      String date, String category) async {
    try {
      DocumentReference document = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .doc(walletName);

      await document.set({
        'records': FieldValue.arrayUnion([
          {
            'title': title,
            'value': value,
            'date': date,
            'category': category,
          },
        ]),
      }, SetOptions(merge: true));
      document.update({
        'balance': FieldValue.increment(value),
      });
      return true;
    } catch (error) {
      logger.e('Error creating new transaction record: $error');
      return false;
    }
  }

  Future<String?> getSelectedWallet() async {
    try {
      DocumentReference document =
          FirebaseFirestore.instance.collection('users').doc(uid);

      DocumentSnapshot documentSnapshot = await document.get();

      if (documentSnapshot.exists) {
        var value = documentSnapshot['selected_wallet'];
        logger.i('selected Wallet: $value');
        return value;
      } else {
        logger.e('Wallet not found');
        return null;
      }
    } catch (e) {
      logger.e('Error: $e');
      return null;
    }
  }

  Future<double?> getBalance(walletName) async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .doc(walletName);

      DocumentSnapshot document = await documentReference.get();

      if (document.exists) {
        var value = document['balance'];
        logger.i('Balance is: $value');
        return value;
      } else {
        logger.w('Wallet: $walletName not found');
        return null;
      }
    } catch (e) {
      logger.e('Error: $e');
      return null;
    }
  }

  Future<List<dynamic>?> getTransactionRecords(walletName) async {
    try {
      DocumentReference documentReference = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('wallets')
          .doc(walletName);

      DocumentSnapshot document = await documentReference.get();

      if (document.exists) {
        var value = document['records'];
        logger.i('records: $value');
        return value;
      } else {
        logger.e('records not found');
        return null;
      }
    } catch (e) {
      logger.e('Error getting records: $e');
      return null;
    }
  }
}
