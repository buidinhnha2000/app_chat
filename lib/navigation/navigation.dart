import 'package:flutter/material.dart';

import '../models/user/user.dart';
import '../screens/home/home.dart';
import '../screens/profile/profile.dart';
import '../screens/search/search.dart';
import '../screens/user_chat/user_chat.dart';
import '../screens/user_profile/user_profile.dart';

abstract class AppRoutes {
  static const home = '/';
  static const userChat = 'user_chat';
  static const userProfile = 'user_profile';
  static const profile = 'profile';
  static const search = 'search';
}

abstract class AppNavigation {
  static Route<dynamic>? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return AppPageRoute((_) => const HomeScreen(), settings);
      case AppRoutes.profile:
        return AppPageRoute((_) => ProfileScreen(user: settings.arguments as ChatUser), settings);
      case AppRoutes.search:
        return AppPageRoute((_) => const SearchScreen(), settings);
      case AppRoutes.userProfile:
        return AppPageRoute((_) => UserProfileScreen(userProfile: settings.arguments as ChatUser), settings);
      case AppRoutes.userChat:
        return AppPageRoute((_) => UserChatScreen(user: settings.arguments as ChatUser), settings);
      default:
        throw 'Cannot find destination route';
    }
  }
}

/// This function ensures the RouteSettings parameter will be pass into a destination route
/// to make sure every destination has a settings
// ignore: non_constant_identifier_names
MaterialPageRoute<T> AppPageRoute<T>(
  Widget Function(BuildContext context) builder,
  RouteSettings settings, {
  bool maintainState = true,
  bool fullscreenDialog = false,
}) =>
    MaterialPageRoute(
      builder: builder,
      settings: settings,
      maintainState: maintainState,
      fullscreenDialog: fullscreenDialog,
    );
