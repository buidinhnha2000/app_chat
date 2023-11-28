import 'package:flutter/material.dart';

import '../../common/extensions/context.dart';
import '../../common/resources/app_icon.dart';
import '../../common/widgets/svg_button.dart';
import '../../models/model_class/icons.dart';
import '../../models/user/user.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    final List<ModelIcon> icons = [
      ModelIcon(icons: AppIcons.iconKeys, title: 'Account', des: 'Privacy, security, change number'),
      ModelIcon(icons: AppIcons.iconMessage, title: 'Chat', des: 'Chat history,theme,wallpapers'),
      ModelIcon(icons: AppIcons.iconNotification, title: 'Notifications', des: 'Messages, group and others'),
      ModelIcon(icons: AppIcons.iconHelp, title: 'Help', des: 'Help center,contact us, privacy policy'),
      ModelIcon(icons: AppIcons.iconData, title: 'Storage and data', des: 'Network usage, storage usage'),
      ModelIcon(icons: AppIcons.iconUser, title: 'Invite a friend', des: ''),
      ModelIcon(icons: AppIcons.iconBack, title: 'Log out', des: ''),
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SvgButton(AppIcons.iconBack, color: Colors.white, onTap: () => context.navigator.pop()),
                ),
                const Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                const SizedBox(width: 50),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                child: Container(
                  color: context.theme.colorScheme.onPrimary,
                  child: ListView(
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 24),
                          height: 3,
                          width: 30,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: context.theme.colorScheme.background),
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
                                    Text(user.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black)),
                                    const SizedBox(height: 6),
                                    Text(user.about, style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5))),
                                  ],
                                )
                              ],
                            ),
                            const SvgButton(AppIcons.iconQr, color: Colors.green),
                          ],
                        ),
                      ),
                      Divider(color: Colors.black.withOpacity(0.2)),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        shrinkWrap: true,
                        itemCount: icons.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(top: 30),
                            height: 44,
                            child: Row(
                              children: [
                                Container(
                                  height: 44,
                                  width: 44,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(22)
                                  ),
                                  child: SvgButton(icons[index].icons, color: Colors.black54),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(icons[index].title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
                                    icons[index].des.isNotEmpty ? const SizedBox(height: 6) : const SizedBox.shrink(),
                                    icons[index].des.isNotEmpty ? Text(icons[index].des, style: TextStyle(fontSize: 12, color: Colors.black.withOpacity(0.5))) : const SizedBox.shrink(),
                                  ],
                                )
                              ],
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
