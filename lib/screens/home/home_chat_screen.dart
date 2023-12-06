import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/context.dart';
import '../../data/api_firebase/chat_provider.dart';
import 'component/home_chat_appbar.dart';
import 'component/home_chat_horizontal.dart';
import 'component/home_chat_vertical.dart';

class ChatHomeScreen extends StatefulWidget {
  const ChatHomeScreen({super.key});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<ChatProvider>().getAllUsers();
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, data, child) {
        final users = data.users;
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: WillPopScope(
              onWillPop: () {
                return Future.value(true);
              },
              child: Scaffold(
                backgroundColor: context.theme.colorScheme.onBackground,
                body: Column(
                  children: [
                    HomeChatAppBar(user: data.userProfile),
                    data.users.isNotEmpty ? HomeChatHorizontal(users: users, user: data.userProfile) : const SizedBox(height: 82),
                    const SizedBox(height: 30),
                    HomeChatVertical(users),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
