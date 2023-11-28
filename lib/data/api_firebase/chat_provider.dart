import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../models/message/message.dart';
import '../../models/user/user.dart';

class ChatProvider extends ChangeNotifier {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static ChatUser userProfileTest = const ChatUser(
    id: '1',
    image: 'image',
    about: 'about',
    name: 'name',
    createdAt: 'createdAt',
    lastActive: 'lastActive',
    email: 'email',
    pushToken: 'pushToken',
    isOnline: true,
  );

  // Create
  String idd = '1';
  List<ChatUser> _users = [];
  List<ChatUser> _usersSearch = [];
  List<ChatMessage> _messageUserByYour = [];
  List<ChatMessage> _messageYourByUser = [];
  String _userId = '';

  ChatUser _userProfileTest = userProfileTest;

  // Getter
  User get user => auth.currentUser!;

  ChatUser get userProfile => _userProfileTest;

  List<ChatUser> get users => _users;

  List<ChatUser> get usersSearch => _usersSearch;

  List<ChatMessage> get messageUserByYour => _messageUserByYour;

  List<ChatMessage> get messageYourByUser => _messageYourByUser;

  String get userId => _userId;

  // Function
  void setUser(ChatUser user) {
    _userId = user.id;
    notifyListeners();
  }

  Future<void> getAllUsers() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await fireStore.collection('users').where('id').where('id', isNotEqualTo: idd).get();
    _users = snapshot.docs.map((doc) => ChatUser.fromJson(doc.data())).toList();
    notifyListeners();
  }

  Future<void> getProfile() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await fireStore.collection('users').where('id').where('id', isEqualTo: idd).get();
    _userProfileTest = snapshot.docs.map((doc) => ChatUser.fromJson(doc.data())).toList().first;
    notifyListeners();
  }

  Future<void> getMessageByUser(String idUser) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await fireStore.collection('messages').where('fromId', isEqualTo: idd).where('toId', isEqualTo: idUser).get();

      _messageYourByUser = snapshot.docs.map((doc) => ChatMessage.fromJson(doc.data())).toList();
      notifyListeners();
    } on Exception catch (e) {
      log('Error getting messages: $e');
    }
  }

  Future<void> getMessageByYour(String idUser) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await fireStore.collection('messages').where('fromId', isEqualTo: idUser).where('toId', isEqualTo: idd).get();

      _messageUserByYour = snapshot.docs.map((doc) => ChatMessage.fromJson(doc.data())).toList();
      notifyListeners();
    } on Exception catch (e) {
      log('Error getting messages: $e');
    }
  }

  Future<void> sendMessage(
      {required String msg, required String dateTime, required String userId, required TypeMessage typeMessage}) async {
    try {
      final chatMessage =
          ChatMessage(id: const Uuid().v4(), toId: idd, msg: msg, read: 'read', fromId: userId, sent: dateTime, type: typeMessage);
      await fireStore.collection('messages').doc(chatMessage.id).set(chatMessage.toJson());

      final QuerySnapshot<Map<String, dynamic>> snapshotYourByUser =
          await fireStore.collection('messages').where('fromId', isEqualTo: idd).where('toId', isEqualTo: userId).get();
      final QuerySnapshot<Map<String, dynamic>> snapshotUserByYour =
          await fireStore.collection('messages').where('fromId', isEqualTo: userId).where('toId', isEqualTo: idd).get();

      _messageYourByUser = snapshotYourByUser.docs.map((doc) => ChatMessage.fromJson(doc.data())).toList();
      _messageUserByYour = snapshotUserByYour.docs.map((doc) => ChatMessage.fromJson(doc.data())).toList();

      notifyListeners();
    } on Exception catch (e) {
      log('Error getting messages: $e');
    }
  }

  Future<void> deleteMessage({required String idMessage}) async {
    try {
      await fireStore.collection('messages').doc(idMessage).delete();
      final QuerySnapshot<Map<String, dynamic>> snapshotYourByUser =
          await fireStore.collection('messages').where('fromId', isEqualTo: idd).where('toId', isEqualTo: userId).get();
      final QuerySnapshot<Map<String, dynamic>> snapshotUserByYour =
          await fireStore.collection('messages').where('fromId', isEqualTo: userId).where('toId', isEqualTo: idd).get();

      _messageYourByUser = snapshotYourByUser.docs.map((doc) => ChatMessage.fromJson(doc.data())).toList();
      _messageUserByYour = snapshotUserByYour.docs.map((doc) => ChatMessage.fromJson(doc.data())).toList();

      notifyListeners();
    } on Exception catch (e) {
      log('Error getting messages: $e');
    }
  }

  Future<void> getSearch(String searchQuery) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await fireStore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: searchQuery)
        .where('name', isLessThan: '${searchQuery}z')
        .get();
    _usersSearch = snapshot.docs.map((doc) => ChatUser.fromJson(doc.data())).toList();
    notifyListeners();
  }

  void resetMessage() {
    _messageUserByYour = [];
    _messageYourByUser = [];
    notifyListeners();
  }
}
