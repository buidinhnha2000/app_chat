import 'package:flutter/material.dart';

import '../../common/extensions/context.dart';
import '../../common/resources/app_icon.dart';
import '../../common/widgets/svg_button.dart';
import '../../models/model_class/icons.dart';
import '../../models/user/user.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key, required this.userProfile});

  final ChatUser userProfile;

  @override
  Widget build(BuildContext context) {
    final List<ModelIcon> icons = [
      ModelIcon(icons: AppIcons.iconMessage, title: 'Account', des: 'Privacy, security, change number'),
      ModelIcon(icons: AppIcons.iconVideo, title: 'Chat', des: 'Chat history,theme,wallpapers'),
      ModelIcon(icons: AppIcons.iconCall, title: 'Notifications', des: 'Messages, group and others'),
      ModelIcon(icons: AppIcons.iconMore, title: 'Help', des: 'Help center,contact us, privacy policy'),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SvgButton(AppIcons.iconBack, color: Colors.white, onTap: () => context.navigator.pop()),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 82,
                  height: 82,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: ClipOval(
                    child: Image.network(userProfile.image, fit: BoxFit.fill),
                  ),
                ),
                const SizedBox(height: 12),
                Text(userProfile.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(height: 8),
                Text(userProfile.email, style: const TextStyle(fontSize: 12, color: Colors.white54)),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 24),
                    height: 44,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        icons.length,
                        (index) => Container(
                          margin: const EdgeInsets.only(right: 8),
                          // Adjust the spacing between items as needed
                          height: 44,
                          width: 44,
                          decoration:
                              BoxDecoration(color: Colors.greenAccent.shade700.withOpacity(0.2), borderRadius: BorderRadius.circular(22)),
                          child: SvgButton(
                            icons[index].icons,
                            color: Colors.white,
                            onTap: () {
                              if(index == 0) {
                                context.navigator.pop();
                              }
                            },
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                child: Container(
                  color: context.theme.colorScheme.onPrimary,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 24),
                          height: 3,
                          width: 30,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: context.theme.colorScheme.background),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Display Name', style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5))),
                            const SizedBox(height: 10),
                            Text(' ${userProfile.name}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Email Address', style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5))),
                            const SizedBox(height: 10),
                            Text(' ${userProfile.email}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Address', style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5))),
                            const SizedBox(height: 10),
                            Text(' ${userProfile.about}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Phone Number', style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.5))),
                            const SizedBox(height: 10),
                            Text(' ${userProfile.createdAt}',
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black)),
                          ],
                        ),
                      )
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
