import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

import '../../models/comment/comment.dart';
import '../../models/dtos_entity/post_entity/post_entity.dart';
import '../../models/dtos_entity/quiz_entity/quiz_entity.dart';
import '../../models/post/post.dart';
import '../../models/quiz/quiz.dart';
import '../../models/quiz_item/quiz_item.dart';
import '../../models/user/user.dart';

class AppProvider extends ChangeNotifier {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
  static FirebaseStorage storage = FirebaseStorage.instance;

  ChatUser userDefault = const ChatUser(
      id: 'id',
      image: 'image',
      about: 'about',
      name: 'name',
      createdAt: 'createdAt',
      lastActive: 'lastActive',
      email: 'email',
      pushToken: 'pushToken',
      isOnline: true);
  QuizEntity quizDefault =
      const QuizEntity(id: 'id', quiz: Quiz(id: 'id', title: 'title', image: 'image', correct: 'correct'), quizItems: []);

  int _tab = 0;
  List<PostEntity> _posts = [];
  List<QuizEntity> _quizs = [];
  List<Comment> _comments = [];
  List<Comment> _childComments = [];

  int get tab => _tab;

  List<PostEntity> get posts => _posts;

  List<QuizEntity> get quizs => _quizs;

  List<Comment> get comments => _comments;

  List<Comment> get childComments => _childComments;

  Future<void> getBasicQuiz() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> quizSnapshot = await fireStore.collection('quizs').get();
      final List<Quiz> quizs = quizSnapshot.docs.map((doc) => Quiz.fromJson(doc.data())).toList();
      final List<QuizEntity> quizEntities = [];
      for (final quiz in quizs) {
        final List<QuizItem> quizItemss = [];

        for (final quizId in quiz.quizItem) {
          final QuerySnapshot<Map<String, dynamic>> quizItemSnapshot =
              await fireStore.collection('quizItem').where('id', isEqualTo: quizId).get();

          final List<QuizItem> quizItems = quizItemSnapshot.docs.map((doc) {
            final QuizItem quizItem = QuizItem.fromJson(doc.data());
            return quizItem;
          }).toList();

          quizItemss.addAll(quizItems);
        }

        quizEntities.add(QuizEntity(id: quiz.id, quiz: quiz, quizItems: quizItemss));
      }

      _quizs = quizEntities;

      notifyListeners();
    } on Exception catch (e) {
      log('Error fetching quizzes: $e');
    }
  }

  Future<void> getAllPost() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> postSnapshot = await fireStore.collection('posts').get();
      final List<Post> posts = postSnapshot.docs.map((doc) => Post.fromJson(doc.data())).toList();

      final userIds = posts.map((post) => post.userId).toSet();
      final QuerySnapshot<Map<String, dynamic>> userSnapshot =
          await fireStore.collection('users').where('id', whereIn: userIds.toList()).get();

      final Map<String, ChatUser> userMap = Map.fromEntries(userSnapshot.docs.map((doc) {
        final ChatUser user = ChatUser.fromJson(doc.data());
        return MapEntry(user.id, user);
      }));

      _posts = posts.map((post) {
        final ChatUser user = userMap[post.userId] ?? userDefault;
        return PostEntity(
          id: post.id,
          userId: post.userId,
          title: post.title,
          image: post.image,
          createdAt: post.createdAt,
          favorite: post.favorite,
          like: post.like,
          message: post.message,
          user: user,
        );
      }).toList();

      _posts.sort((a, b) => DateTime.parse(b.createdAt).compareTo(DateTime.parse(a.createdAt)));
      notifyListeners();
    } on Exception catch (e) {
      log('Error fetching posts: $e');
    }
  }

  Future<void> createPost({required String title, required String userId}) async {
    try {
      final postEntity = PostEntity(
        id: const Uuid().v4(),
        userId: userId,
        title: title,
        image: '',
        createdAt: DateTime.now().toString(),
        favorite: 0,
        like: 0,
        message: 0,
      );
      await fireStore.collection('posts').doc(postEntity.id).set(postEntity.toJson());
      await getAllPost();
      notifyListeners();
    } on Exception catch (e) {
      log('Error creating Room: $e');
    }
  }

  Future<void> getCommentByPost(String postId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> commentSnapshot = await fireStore.collection('comments').where('postId', isEqualTo: postId).get();
      final List<Comment> commentsOutput = commentSnapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList();

      _comments = commentsOutput;

      notifyListeners();
    } on Exception catch (e) {
      log('Error fetching quizzes: $e');
    }
  }

  Future<void> getCommentByComment(String commentId) async {
    try {
      final QuerySnapshot<Map<String, dynamic>> commentChildSnapshot = await fireStore.collection('comments').where('commentId', isEqualTo: commentId).get();
      final List<Comment> childCommentsOutput = commentChildSnapshot.docs.map((doc) => Comment.fromJson(doc.data())).toList();

      _childComments = childCommentsOutput;

      notifyListeners();
    } on Exception catch (e) {
      log('Error fetching quizzes: $e');
    }
  }

  void onChangedTab(int tab) {
    _tab = tab;
    notifyListeners();
  }

  void setInitTimerCountDown() {
    notifyListeners();
  }
}
