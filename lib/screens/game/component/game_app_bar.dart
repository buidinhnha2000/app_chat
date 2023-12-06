import 'package:flutter/material.dart';

import '../../../common/extensions/context.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../models/user/user.dart';
import '../../../navigation/navigation.dart';

class GameAppBar extends StatelessWidget {
  const GameAppBar({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  SvgButton(AppIcons.iconUser, color: context.theme.colorScheme.secondaryContainer),
                  const SizedBox(width: 5),
                  Text(
                    'GOOD MORNING',
                    style: context.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.secondaryContainer),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Text(
                user.name,
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.w900, color: context.theme.colorScheme.primary, letterSpacing: 2),
              ),
            ],
          ),
          GestureDetector(
            onTap: () => context.navigator.pushNamed(AppRoutes.profile, arguments: user),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: context.theme.colorScheme.onPrimary.withOpacity(0.4), width: 2),
                  image: user.image.isNotEmpty ? DecorationImage(image: NetworkImage(user.image), fit: BoxFit.fill) : null),
            ),
          ),
        ],
      ),
    );
  }
}
