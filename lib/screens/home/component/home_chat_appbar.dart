import 'package:flutter/material.dart';

import '../../../common/extensions/context.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../models/user/user.dart';
import '../../../navigation/navigation.dart';

class HomeChatAppBar extends StatelessWidget {
  const HomeChatAppBar({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: context.theme.colorScheme.onPrimary.withOpacity(0.2), width: 2)),
            child: Center(
              child: SvgButton(
                AppIcons.iconSearch,
                color: context.theme.colorScheme.onPrimary,
                onTap: () => context.navigator.pushNamed(AppRoutes.search),
              ),
            ),
          ),
          Text(
            'Home',
            style: context.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600, color: context.theme.colorScheme.onPrimary),
          ),
          GestureDetector(
            onTap: () => context.navigator.pushNamed(AppRoutes.profile, arguments: user),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(color: context.theme.colorScheme.onPrimary.withOpacity(0.4), width: 2),
                  image: user.image.isNotEmpty ? DecorationImage(image: NetworkImage(user.image), fit: BoxFit.fill) : null),
            ),
          )
        ],
      ),
    );
  }
}
