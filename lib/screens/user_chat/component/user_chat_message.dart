import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/context.dart';
import '../../../common/extensions/date_time.dart';
import '../../../common/widgets/bottom_sheet.dart';
import '../../../data/api_firebase/chat_provider.dart';
import '../../../models/message/message.dart';
import '../../../models/user/user.dart';
import '../../home/component/home_chat_user_bottom_sheet.dart';

class UserChatMessage extends StatelessWidget {
  const UserChatMessage({super.key, required this.user, this.messages, required this.userId});

  final ChatUser user;
  final List<ChatMessage>? messages;
  final String userId;

  @override
  Widget build(BuildContext context) {
    bool onTimeMinute(String timeMinuteIndex, String timeMinuteIndexFirst, int index, bool trueId) {
      if (trueId == false) {
        return true;
      } else {
        if (index == 0) {
          return true;
        } else {
          if (timeMinuteIndex == timeMinuteIndexFirst) {
            return false;
          } else {
            return true;
          }
        }
      }
    }

    bool onTimeDay(String timeMinuteIndex, String timeMinuteIndexLast, int index, int length) {
      if (index == length - 1) {
        return true;
      }
      if (timeMinuteIndex == timeMinuteIndexLast) {
        return false;
      } else {
        return true;
      }
    }

    return FutureBuilder(
      future: context.read<ChatProvider>().loadMessage(),
      builder: (context, snapshot) {
        return ListView.builder(
          reverse: true,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(top: 80, left: 24, right: 24),
          itemCount: messages?.length ?? 0,
          itemBuilder: (context, index) {
            //Time minute
            final timeMinute = DateTime.parse(messages?[index].sent ?? ChatDateTime.dayNow.toString()).formattedHour;
            final timeMinuteIndex = DateTime.parse(messages?[index].sent ?? ChatDateTime.dayNow.toString()).formattedMinute;
            final timeMinuteIndexFirst =
                DateTime.parse(messages?[index == 0 ? index : index - 1].sent ?? ChatDateTime.dayNow.toString()).formattedMinute;
            final toId1 = messages?[index].toId;
            final toId2 = messages?[index == 0 ? index : index - 1].toId;
            final trueId = toId1 == toId2 ? true : false;
            final showTime = onTimeMinute(timeMinuteIndex, timeMinuteIndexFirst, index, trueId);

            //Time day
            final timeDay = DateTime.parse(messages?[index].sent ?? ChatDateTime.dayNow.toString()).formattedDate;
            final timeNow = ChatDateTime.dayNow.formattedDate;
            final timeDayIndex = DateTime.parse(messages?[index].sent ?? ChatDateTime.dayNow.toString()).formattedDate;
            final timeDayIndexLast =
                DateTime.parse(messages?[index == (messages?.length ?? 1) - 1 ? index : index + 1].sent ?? ChatDateTime.dayNow.toString())
                    .formattedDate;
            final showDay = onTimeDay(timeDayIndex, timeDayIndexLast, index, messages?.length ?? 0);

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showDay == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                timeNow == timeDay ? 'Today' : timeDay,
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  Row(
                    mainAxisAlignment: messages?[index].toId == userId ? MainAxisAlignment.start : MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      messages?[index].toId == userId
                          ? Container(
                              margin: const EdgeInsets.only(right: 12),
                              child: ClipOval(
                                child: Image.network(user.image, fit: BoxFit.fill, height: 40, width: 40),
                              ),
                            )
                          : const SizedBox.shrink(),
                      Column(
                        crossAxisAlignment: messages?[index].toId == userId ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onLongPress: () {
                              if (messages?[index].fromId == userId) {
                                BottomSheetChat.show(
                                  context,
                                  child: HomeChatUserBottomSheet(
                                    onAdd: () {},
                                    onCreate: () {},
                                    onDelete: () async {
                                      context.navigator.pop();
                                      await Provider.of<ChatProvider>(context, listen: false)
                                          .deleteMessage(idMessage: messages?[index].id ?? '');
                                    },
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              margin: EdgeInsets.only(
                                  left: messages?[index].toId == userId ? 0 : 100, right: messages?[index].toId == userId ? 100 : 0),
                              decoration: BoxDecoration(
                                color: messages?[index].toId == userId
                                    ? context.theme.colorScheme.secondary
                                    : context.theme.colorScheme.secondaryContainer,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: const Radius.circular(12),
                                  bottomRight: const Radius.circular(12),
                                  topLeft: Radius.circular(messages?[index].toId == userId ? 0 : 12),
                                  topRight: Radius.circular(messages?[index].toId == userId ? 12 : 0),
                                ),
                              ),
                              child: Text(
                                '${messages?[index].msg}',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: messages?[index].toId == userId
                                      ? context.theme.colorScheme.primary
                                      : context.theme.colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                          showTime == true
                              ? Padding(
                                  padding: const EdgeInsets.only(top: 8, left: 12, right: 12, bottom: 10),
                                  child: Text(
                                    timeMinute,
                                    style: context.textTheme.bodySmall?.copyWith(
                                      color: context.theme.colorScheme.primary.withOpacity(0.6),
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ],
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
