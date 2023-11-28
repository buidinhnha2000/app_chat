import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/context.dart';
import '../../../data/api_firebase/chat_provider.dart';
import '../../../models/user/user.dart';
import '../../../common/widgets/bottom_sheet.dart';
import '../../../navigation/navigation.dart';
import 'home_chat_user_bottom_sheet.dart';

class HomeChatVertical extends StatelessWidget {
  const HomeChatVertical(this.users, {super.key});

  final List<ChatUser> users;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        child: Container(
          color: context.theme.colorScheme.onPrimary,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 14, bottom: 24),
                  height: 3,
                  width: 30,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: context.theme.colorScheme.background),
                ),
              ),
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: users.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: const EdgeInsets.all(0),
                    onTap: () {
                      context.read<ChatProvider>().setUser(users[index]);
                      context.navigator.pushNamed(AppRoutes.userChat, arguments: users[index]);
                    },
                    onLongPress: () {
                      BottomSheetChat.show(
                        context,
                        child: HomeChatUserBottomSheet(
                          onAdd: () {},
                          onCreate: () {},
                          onDelete: () {},
                        ),
                      );
                    },
                    title: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      margin: const EdgeInsets.only(bottom: 30),
                      height: 52,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 12),
                                    width: 52,
                                    height: 52,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(29),
                                    ),
                                    child: ClipOval(
                                      child: Image.network(users[index].image, fit: BoxFit.fill),
                                    ),
                                  ),
                                  users[index].isOnline
                                      ? Positioned(
                                          right: 10,
                                          bottom: 0,
                                          child: Container(
                                            height: 14,
                                            width: 14,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: Colors.green,
                                                border: Border.all(width: 2, color: context.theme.colorScheme.onPrimary)),
                                          ),
                                        )
                                      : const SizedBox.shrink(),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    users[index].name,
                                    style: context.textTheme.titleLarge?.copyWith(
                                      color: context.theme.colorScheme.background,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'You: How are you today?',
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.theme.colorScheme.background.withOpacity(0.5),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '2 min ago',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  color: context.theme.colorScheme.background.withOpacity(0.5),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(right: 1, bottom: 1),
                                height: 22,
                                width: 22,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: context.theme.colorScheme.error.withOpacity(0.9),
                                ),
                                child: Center(child: Text(index.toString())),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
