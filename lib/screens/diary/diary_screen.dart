import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/context.dart';
import '../../data/api_firebase/chat_provider.dart';
import 'component/diary_app_bar.dart';
import 'component/diary_widget.dart';

class DiaryScreen extends StatefulWidget {
  const DiaryScreen({super.key});

  @override
  State<DiaryScreen> createState() => _DiaryScreenState();
}

class _DiaryScreenState extends State<DiaryScreen> {
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
                    DiaryAppBar(user: dataChat.userProfile),
                    const DiaryWidget(),
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
