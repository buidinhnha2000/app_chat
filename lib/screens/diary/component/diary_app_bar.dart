import 'package:flutter/material.dart';

import '../../../common/extensions/context.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../models/user/user.dart';

class DiaryAppBar extends StatefulWidget {
  const DiaryAppBar({super.key, required this.user});

  final ChatUser user;

  @override
  State<DiaryAppBar> createState() => _DiaryAppBarState();
}

class _DiaryAppBarState extends State<DiaryAppBar> {
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 17, horizontal: 12),
      child: Row(
        children: [
          SizedBox(
            height: 44,
            width: 44,
            child: SvgButton(
              AppIcons.iconHome,
              color: context.theme.colorScheme.primary.withOpacity(0.7),
              onTap: () {},
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(right: 12, left: 12),
              height: 44,
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  suffixIcon: SvgButton(
                    AppIcons.iconRemove,
                    size: 24,
                    onTap: () {
                      setState(() {
                        _textController.text = '';
                      });
                    },
                  ),
                  prefixIcon: const SvgButton(
                    AppIcons.iconSearch,
                    size: 24,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  fillColor: context.theme.colorScheme.secondary,
                  filled: true,
                ),
                style: TextStyle(color: context.theme.colorScheme.primary),
                onChanged: (value) {},
              ),
            ),
          ),
          Container(
            height: 44,
            width: 44,
            decoration: BoxDecoration(color: context.theme.colorScheme.secondary, borderRadius: BorderRadius.circular(22)),
            child: Stack(
              children: [
                Center(
                  child: SvgButton(
                    AppIcons.iconNotification,
                    color: context.theme.colorScheme.primary.withOpacity(0.7),
                    onTap: () {},
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    height: 18,
                    width: 18,
                    decoration: BoxDecoration(color: context.theme.colorScheme.error, borderRadius: BorderRadius.circular(10)),
                    child: const Center(child: Text('1')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
