import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/context.dart';
import '../../data/api_firebase/chat_provider.dart';
import 'component/game_app_bar.dart';
import 'component/game_widget.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, dataChat, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: WillPopScope(
              onWillPop: () {
                return Future.value(true);
              },
              child: Scaffold(
                backgroundColor: context.theme.colorScheme.background,
                body: Column(
                  children: [
                    GameAppBar(user: dataChat.userProfile),
                    GameWidget(user: dataChat.userProfile),
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
