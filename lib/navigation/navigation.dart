import 'package:flutter/material.dart';

import '../models/arguments/call_argument.dart';
import '../models/dice/dice.dart';
import '../models/user/user.dart';
import '../screens/call/call.dart';
import '../screens/call_incoming/call_incoming_screen.dart';
import '../screens/diary/diary.dart';
import '../screens/game/dice/dice.dart';
import '../screens/game/dice/dice_room/dice_room_screen.dart';
import '../screens/game/dice/dice_room_admin/dice_room_admin_screen.dart';
import '../screens/game/view/game_on_boarding.dart';
import '../screens/home/home.dart';
import '../screens/home/home_chat_screen.dart';
import '../screens/profile/profile.dart';
import '../screens/profile/setting/setting.dart';
import '../screens/search/search.dart';
import '../screens/user_chat/user_chat.dart';
import '../screens/user_profile/user_profile.dart';

abstract class AppRoutes {
  static const home = '/';
  static const chatHome = 'chat_home';
  static const userChat = 'user_chat';
  static const userProfile = 'user_profile';
  static const profile = 'profile';
  static const search = 'search';
  static const call = 'call';
  static const callIncoming = 'call_incoming';
  static const setting = 'setting';

  static const diary = 'diary';
  static const gameOnBoarding = 'game_on_boarding';
  static const dice = 'dice';
  static const diceRoom = 'dice_room';
  static const diceRoomAdmin = 'dice_room_admin';
}

abstract class AppNavigation {
  static Route<dynamic>? onGeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.home:
        return AppPageRoute((_) => const HomeScreen(), settings);
      case AppRoutes.chatHome:
        return AppPageRoute((_) => const ChatHomeScreen(), settings);
      case AppRoutes.profile:
        return AppPageRoute((_) => ProfileScreen(user: settings.arguments as ChatUser), settings);
      case AppRoutes.search:
        return AppPageRoute((_) => const SearchScreen(), settings);
      case AppRoutes.userProfile:
        return AppPageRoute((_) => UserProfileScreen(userProfile: settings.arguments as ChatUser), settings);
      case AppRoutes.userChat:
        return AppPageRoute((_) => UserChatScreen(user: settings.arguments as ChatUser), settings);
      case AppRoutes.call:
        return AppPageRoute((_) => CallScreen(callArgument: settings.arguments as CallArgument), settings);
      case AppRoutes.callIncoming:
        return AppPageRoute((_) => CallIncomingScreen(callArgument: settings.arguments as CallArgument), settings);
      case AppRoutes.setting:
        return AppPageRoute((_) => const SettingScreen(), settings);

      case AppRoutes.diary:
        return AppPageRoute((_) => const DiaryScreen(), settings);

      case AppRoutes.gameOnBoarding:
        return AppPageRoute((_) => const GameOnBoarding(), settings);
      case AppRoutes.dice:
        return AppPageRoute((_) => DiceScreen(user: settings.arguments as ChatUser), settings);
      case AppRoutes.diceRoom:
        return AppPageRoute((_) => DiceRoomScreen(dice: settings.arguments as Dice), settings);
      case AppRoutes.diceRoomAdmin:
        return AppPageRoute((_) => DiceRoomAdminScreen(dice: settings.arguments as Dice), settings);

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
