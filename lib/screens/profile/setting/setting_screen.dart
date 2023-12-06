import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/context.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../data/api_firebase/chat_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, data, child) {
      return Scaffold(
        backgroundColor: context.theme.colorScheme.onBackground,
        body: Column(
          children: [
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: SvgButton(AppIcons.iconBack, color: context.theme.colorScheme.onPrimary, onTap: () => context.navigator.pop()),
                ),
                Text('Settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: context.theme.colorScheme.onPrimary)),
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
                    padding: EdgeInsets.zero,
                    children: [
                      Center(
                        child: Container(
                          margin: const EdgeInsets.only(top: 14, bottom: 24),
                          height: 3,
                          width: 30,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: context.theme.colorScheme.primary),
                        ),
                      ),
                      Divider(color: context.theme.colorScheme.onBackground.withOpacity(0.4)),
                      ListView(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              margin: const EdgeInsets.only(top: 30),
                              height: 44,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 44,
                                        width: 44,
                                        decoration: BoxDecoration(
                                            color: context.theme.colorScheme.primary.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(22)),
                                        child: Icon(
                                          Icons.dark_mode,
                                          color: context.theme.colorScheme.primary,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Dark Mode',
                                              style: TextStyle(
                                                  fontSize: 16, fontWeight: FontWeight.w600, color: context.theme.colorScheme.primary)),
                                          const SizedBox(height: 6),
                                          Text('Color dark mode by theme',
                                              style: TextStyle(fontSize: 12, color: context.theme.colorScheme.primary.withOpacity(0.5))),
                                        ],
                                      )
                                    ],
                                  ),
                                  CupertinoSwitch(
                                    value: data.darkMode,
                                    activeColor: context.theme.colorScheme.primary,
                                    onChanged: (value) => Provider.of<ChatProvider>(context, listen: false).setDarkMode(),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
