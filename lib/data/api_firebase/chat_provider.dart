import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../common/regex/regex.dart';
import '../../models/message/message.dart';
import '../../models/topic_message/topic_message.dart';
import '../../models/user/user.dart';

class ChatProvider extends ChangeNotifier {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  static ChatUser userProfileTest = const ChatUser(
    id: '2',
    image: '',
    about: 'about',
    name: 'name',
    createdAt: 'createdAt',
    lastActive: 'lastActive',
    email: 'email',
    pushToken: 'pushToken',
    isOnline: true,
  );

  // Create
  String idd = '2';
  List<ChatUser> _users = [];
  List<ChatUser> _usersSearch = [];
  List<ChatMessage> _messageUserByYour = [];
  List<ChatMessage> _messageYourByUser = [];
  String _userId = '';
  bool _darkMode = false;
  TopicMessage? _topicMessage;
  String? _topicId;

  ChatUser _userProfileTest = userProfileTest;

  // Getter
  bool get darkMode => _darkMode;

  User get user => auth.currentUser!;

  ChatUser get userProfile => _userProfileTest;

  List<ChatUser> get users => _users;

  List<ChatUser> get usersSearch => _usersSearch;

  List<ChatMessage> get messageUserByYour => _messageUserByYour;

  List<ChatMessage> get messageYourByUser => _messageYourByUser;

  String get userId => _userId;

  String? get topicId => _topicId;

  TopicMessage? get topicMessage => _topicMessage;

  // Function
  void setUser(ChatUser user) {
    _userId = user.id;
    notifyListeners();
  }

  void setDarkMode() {
    _darkMode = !_darkMode;
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

  Future<void> loadMessage() async {
    try {
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

  void getSearch(String searchQuery) async {
    _usersSearch = _users.where((user) {
      final normalizedQuery = removeDiacritics(searchQuery.toLowerCase());
      final normalizedItem = removeDiacritics(user.name.toLowerCase());
      return normalizedItem.contains(normalizedQuery);
    }).toList();
    notifyListeners();
  }

  Future<void> getTopicMessage(String id1, String id2) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await fireStore.collection('topics').where('id').where('id', isEqualTo: '$idd$id2').get();

      if (snapshot.docs.isNotEmpty) {
        final image = TopicMessage.fromJson(snapshot.docs.first.data());
        _topicMessage = image;
        _topicId = '$idd$userId';
      } else {
        final QuerySnapshot<Map<String, dynamic>> snapshot1 =
            await fireStore.collection('topics').where('id').where('id', isEqualTo: '$id2$idd').get();
        if (snapshot1.docs.isNotEmpty) {
          final image = TopicMessage.fromJson(snapshot1.docs.first.data());
          _topicMessage = image;
          _topicId = '$userId$idd';
        } else {
          _topicMessage = null;
        }
      }

      notifyListeners();
    } on Exception catch (e) {
      log('Error getting topic message: $e');
    }
  }

  Future<void> setTopicMessage(String id1, String id2, int topic) async {
    try {
      final topicId1 = '$idd$id2';
      final topicInput = TopicMessage(id: topicId ?? topicId1, image: topic);
      final querySnapshot = await fireStore.collection('topics').where('id').where('id', isEqualTo: topicInput.id).get();

      if (querySnapshot.docs.isNotEmpty) {
        await fireStore.collection('topics').doc(querySnapshot.docs.first.id).update({'image': topic});
      } else {
        await fireStore.collection('topics').doc(topicId1).set({'id': topicId1, 'image': topic});
      }

      _topicMessage = topicInput;
      notifyListeners();
    } on Exception catch (e) {
      log('Error setting topic message: $e');
    }
  }

  Future<void> deleteTopicMessage() async {
    try {
      await fireStore.collection('topics').doc(topicId).delete();
      _topicMessage = null;

      notifyListeners();
    } on Exception catch (e) {
      log('Error getting messages: $e');
    }
  }

  void resetMessage() {
    _messageYourByUser = [];
    _messageUserByYour = [];
    _topicMessage = null;
    notifyListeners();
  }
}
