import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/context.dart';
import '../../common/resources/app_image.dart';
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
      Provider.of<ChatProvider>(context, listen: false).getTopicMessage('1', widget.user.id);
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String? _imageTopic(int index) {
    switch (index) {
      case 1:
        return AppImages.topic1;
      case 2:
        return AppImages.topic2;
      case 3:
        return AppImages.topic3;
      case 4:
        return AppImages.topic4;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();
    return FutureBuilder(
      future: context.read<ChatProvider>().getTopicMessage('1', widget.user.id),
      builder: (context, snapshot) {
        return Consumer<ChatProvider>(
          builder: (context, data, child) {
            final image = data.topicMessage;
            final messages = [...data.messageYourByUser, ...data.messageUserByYour];
            messages.sort((a, b) => b.sent.compareTo(a.sent));
            return GestureDetector(
              onTap: () => focusNode.unfocus(),
              child: Stack(
                children: [
                  if (image?.image != null && _imageTopic(image!.image) != null)
                    Image.asset(
                      _imageTopic(image.image)!,
                      height: double.infinity,
                      width: double.infinity,
                      fit: BoxFit.fill,
                    )
                  else
                    const SizedBox(),
                  Scaffold(
                    backgroundColor: image != null ? Colors.transparent : context.theme.colorScheme.background,
                    body: Column(
                      children: [
                        UserChatAppBar(user: widget.user),
                        Expanded(
                          child: UserChatMessage(user: widget.user, userId: data.userId, messages: messages),
                        ),
                        UserChatSend(user: widget.user, focusNode: focusNode)
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
