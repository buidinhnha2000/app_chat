import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

import '../../models/dice/dice.dart';

class DiceProvider extends ChangeNotifier {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  Dice userDefault =
      const Dice(id: 'id', roomId: 'roomId', roomName: 'roomName', adminId: 'adminId', adminName: 'adminName', adminAvatar: 'adminAvatar');

  List<Dice> _dices = [];

  List<Dice> get dices => _dices;

  Future<void> getAllDice() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> diceSnapshot = await fireStore.collection('dices').get();
      _dices = diceSnapshot.docs.map((doc) => Dice.fromJson(doc.data())).toList();
      notifyListeners();
    } on Exception catch (e) {
      log('Error fetching Room: $e');
    }
  }

  Future<void> createRoom({required Dice dice}) async {
    try {
      await fireStore.collection('dices').doc(dice.id).set(dice.toJson());
      final QuerySnapshot<Map<String, dynamic>> snapshotDice = await fireStore.collection('dices').get();

      _dices = snapshotDice.docs.map((doc) => Dice.fromJson(doc.data())).toList();
      notifyListeners();
    } on Exception catch (e) {
      log('Error creating Room: $e');
    }
  }

  Future<void> deleteRoom({required String idRoom}) async {
    try {
      await fireStore.collection('dices').doc(idRoom).delete();
      final QuerySnapshot<Map<String, dynamic>> snapshotDice = await fireStore.collection('dices').get();

      _dices = snapshotDice.docs.map((doc) => Dice.fromJson(doc.data())).toList();
      notifyListeners();
    } on Exception catch (e) {
      log('Error delete Room: $e');
    }
  }
}
