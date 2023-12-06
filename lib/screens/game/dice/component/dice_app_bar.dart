import 'package:flutter/material.dart';

import '../../../../common/extensions/context.dart';
import '../../../../common/resources/app_icon.dart';
import '../../../../common/widgets/svg_button.dart';
import '../../../../models/user/user.dart';
import '../../../../navigation/navigation.dart';

class DiceAppBar extends StatelessWidget {
  const DiceAppBar({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(width: 25, child: SvgButton(AppIcons.iconBack, onTap: () => context.navigator.pop())),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      SvgButton(AppIcons.iconDice, color: context.theme.colorScheme.secondaryContainer),
                      const SizedBox(width: 5),
                      Text(
                        user.name.toUpperCase(),
                        style: context.textTheme.bodySmall
                            ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.secondaryContainer),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Text(
                    'Tôm Cua Bầu Cá',
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w900, color: context.theme.colorScheme.primary, letterSpacing: 2),
                  ),
                ],
              ),
            ],
          ),
          GestureDetector(
            onTap: () => context.navigator.pushNamed(AppRoutes.profile, arguments: user),
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: context.theme.colorScheme.onPrimary.withOpacity(0.4), width: 2),
              ),
              child: ClipOval(
                child: Image.network(user.image, fit: BoxFit.fill),
              ),
            ),
          )
        ],
      ),
    );
  }
}
