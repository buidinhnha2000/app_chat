import 'package:flutter/material.dart';

import '../../../common/extensions/context.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/resources/app_image.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../models/user/user.dart';
import '../../../navigation/navigation.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        children: [
          GestureDetector(
            onTap: () => context.navigator.pushNamed(AppRoutes.gameOnBoarding),
            child: Card(
              shadowColor: context.theme.colorScheme.onPrimaryContainer,
              color: context.theme.colorScheme.onPrimaryContainer,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: context.theme.colorScheme.onPrimaryContainer,
                ),
              ),
              margin: const EdgeInsets.only(bottom: 10),
              child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ĐỐ VUI',
                          style: context.textTheme.bodyLarge
                              ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.secondaryContainer),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            SvgButton(AppIcons.iconGiff, color: context.theme.colorScheme.primary),
                            const SizedBox(width: 5),
                            Text(
                              'A Basic Quiz',
                              style: context.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.primary),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '02 / 100',
                          style:
                              context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.primary),
                        ),
                        SvgButton(AppIcons.iconUser, size: 50, color: context.theme.colorScheme.secondaryContainer),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.navigator.pushNamed(AppRoutes.dice, arguments: user),
            child: Card(
              shadowColor: context.theme.colorScheme.onPrimaryContainer,
              color: context.theme.colorScheme.onPrimaryContainer,
              shape: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: context.theme.colorScheme.onPrimaryContainer,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Opacity(opacity: 0.7, child: Image.asset(AppImages.newYear, fit: BoxFit.cover, width: double.infinity, height: 85, cacheHeight: 200,)),
                    Container(
                      padding: const EdgeInsets.all(16),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TÔM CUA BẦU CÁ',
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.secondaryContainer),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  SvgButton(AppIcons.iconDice, color: context.theme.colorScheme.onPrimary),
                                  const SizedBox(width: 5),
                                  Text(
                                    'Tôm-Cua-Bầu-Cá-Nai-Gà',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.onPrimary),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '10 / 100',
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.onPrimary ),
                              ),
                              SvgButton(AppIcons.iconUser, size: 50, color: context.theme.colorScheme.secondaryContainer),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
