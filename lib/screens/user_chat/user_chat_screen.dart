import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/context.dart';
import '../../data/api_firebase/chat_provider.dart';
import '../../models/user/user.dart';
import 'component/user_chat_appbar.dart';
import 'component/user_chat_message.dart';
import 'component/user_chat_send.dart';

class UserChatScreen extends StatefulWidget {
  const UserChatScreen({super.key, required this.user});

  final ChatUser user;

  @override
  State<UserChatScreen> createState() => _UserChatScreenState();
}

class _UserChatScreenState extends State<UserChatScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<ChatProvider>(context, listen: false).getMessageByUser(widget.user.id);
      Provider.of<ChatProvider>(context, listen: false).getMessageByYour(widget.user.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return Consumer<ChatProvider>(
      builder: (context, data, child) {
        final messages = [...data.messageYourByUser, ...data.messageUserByYour];
        messages.sort((a, b) => b.sent.compareTo(a.sent));
        return GestureDetector(
          onTap: () => focusNode.unfocus(),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: context.theme.colorScheme.onBackground,
              body: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                        child: UserChatMessage(user: widget.user, userId: data.userId, messages: messages),
                      ),
                      UserChatSend(user: widget.user, focusNode: focusNode)
                    ],
                  ),
                  UserChatAppBar(user: widget.user),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
