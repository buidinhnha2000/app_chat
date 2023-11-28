import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/context.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../data/api_firebase/chat_provider.dart';
import '../../../models/user/user.dart';
import '../../../navigation/navigation.dart';

class UserChatAppBar extends StatelessWidget {
  const UserChatAppBar({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.colorScheme.onBackground,
      height: 60,
      padding: const EdgeInsets.only(left: 10, right: 10, top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgButton(
                AppIcons.iconBack,
                size: 24,
                onTap: () {
                  context.navigator.pop();
                  Provider.of<ChatProvider>(context, listen: false).resetMessage();
                },
              ),
              GestureDetector(
                onTap: () => context.navigator.pushNamed(AppRoutes.userProfile, arguments: user),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 5, right: 12),
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(29)),
                      child: ClipOval(
                        child: Image.network(user.image, fit: BoxFit.fill),
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 0,
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: user.isOnline ? Colors.green : Colors.grey,
                            border: Border.all(width: 2, color: context.theme.colorScheme.onPrimary)),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: context.theme.colorScheme.background,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    user.isOnline ? 'Active now' : '12 Hour',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: context.theme.colorScheme.background.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SvgButton(
                AppIcons.iconCall,
                size: 24,
                onTap: () => context.navigator.pop(),
              ),
              SvgButton(
                AppIcons.iconVideo,
                size: 24,
                onTap: () => context.navigator.pop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
