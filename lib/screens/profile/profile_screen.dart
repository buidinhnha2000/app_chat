import 'package:flutter/material.dart';

import '../../common/extensions/context.dart';
import '../../common/resources/app_icon.dart';
import '../../common/widgets/svg_button.dart';
import '../../models/model_class/icons.dart';
import '../../models/user/user.dart';
import '../../navigation/navigation.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    final List<ModelIcon> icons = [
      ModelIcon(icons: AppIcons.iconKeys, title: 'Account', des: 'Privacy, security, change number'),
      ModelIcon(icons: AppIcons.iconMessage, title: 'Chat', des: 'Chat history,theme,wallpapers'),
      ModelIcon(icons: AppIcons.iconNotification, title: 'Notifications', des: 'Messages, group and others'),
      ModelIcon(icons: AppIcons.iconHelp, title: 'Settings', des: 'Help center,contact us, privacy policy'),
      ModelIcon(icons: AppIcons.iconData, title: 'Storage and data', des: 'Network usage, storage usage'),
      ModelIcon(icons: AppIcons.iconUser, title: 'Invite a friend', des: ''),
      ModelIcon(icons: AppIcons.iconBack, title: 'Log out', des: ''),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.onBackground,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SvgButton(AppIcons.iconBack, color: context.theme.colorScheme.onPrimary, onTap: () => context.navigator.pop()),
                ),
                Text('My Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: context.theme.colorScheme.onPrimary)),
                const SizedBox(width: 66),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                child: Container(
                  color: context.theme.colorScheme.background,
                  child: ListView(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 24),
                          height: 3,
                          width: 30,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: context.theme.colorScheme.primary),
                        ),
                      ),
                      Container(
                        height: 60,
                        margin: const EdgeInsets.only(left: 24, right: 16, bottom: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(29),
                                  ),
                                  child: ClipOval(
                                    child: Image.network(user.image, fit: BoxFit.fill),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(user.name,
                                        style:
                                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: context.theme.colorScheme.primary)),
                                    const SizedBox(height: 6),
                                    Text(user.about,
                                        style: TextStyle(fontSize: 12, color: context.theme.colorScheme.primary.withOpacity(0.5))),
                                  ],
                                )
                              ],
                            ),
                            const SvgButton(AppIcons.iconQr, color: Colors.green),
                          ],
                        ),
                      ),
                      Divider(color: context.theme.colorScheme.primary.withOpacity(0.4)),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shrinkWrap: true,
                        itemCount: icons.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              if (index == 3) {
                                context.navigator.pushNamed(AppRoutes.setting);
                              }
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 30),
                              height: 44,
                              child: Row(
                                children: [
                                  Container(
                                    height: 44,
                                    width: 44,
                                    decoration: BoxDecoration(
                                        color: context.theme.colorScheme.primary.withOpacity(0.3), borderRadius: BorderRadius.circular(22)),
                                    child: SvgButton(icons[index].icons, color: context.theme.colorScheme.primary.withOpacity(0.7)),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(icons[index].title,
                                          style: TextStyle(
                                              fontSize: 16, fontWeight: FontWeight.w600, color: context.theme.colorScheme.primary)),
                                      icons[index].des.isNotEmpty ? const SizedBox(height: 6) : const SizedBox.shrink(),
                                      icons[index].des.isNotEmpty
                                          ? Text(icons[index].des,
                                              style: TextStyle(fontSize: 12, color: context.theme.colorScheme.primary.withOpacity(0.5)))
                                          : const SizedBox.shrink(),
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
            ),
          ],
        ),
      ),
    );
  }
}
