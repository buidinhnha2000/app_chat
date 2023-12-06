import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/extensions/context.dart';
import '../../../../common/resources/app_icon.dart';
import '../../../../common/widgets/svg_button.dart';
import '../../../../models/user/user.dart';
import '../../../common/extensions/date_time.dart';
import '../../../data/api_firebase/app_provider.dart';

class BottomSheetCreatePost extends StatelessWidget {
  const BottomSheetCreatePost({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 0),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 16, bottom: 20),
                height: 3,
                width: 30,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: context.theme.colorScheme.primary),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white),
                          image: DecorationImage(image: NetworkImage(user.image), fit: BoxFit.fill),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            maxLines: 1,
                            style: TextStyle(
                                color: context.theme.colorScheme.primary, fontWeight: FontWeight.w800, fontSize: 17, letterSpacing: 1),
                          ),
                          const SizedBox(height: 3),
                          Row(
                            children: [
                              SvgButton(
                                AppIcons.iconUser,
                                color: context.theme.colorScheme.primary.withOpacity(0.8),
                                size: 15,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                DateTime.now().formattedHour,
                                maxLines: 1,
                                style: TextStyle(
                                    color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w400, fontSize: 13),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 44,
                    width: 44,
                    decoration: BoxDecoration(color: context.theme.colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(22)),
                    child: SvgButton(
                      AppIcons.iconSend,
                      color: Colors.white,
                      onTap: () async{
                        await context.read<AppProvider>().createPost(title: titleController.text, userId: user.id);
                        if(context.mounted) {
                          context.navigator.pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.theme.colorScheme.secondary,
              ),
              child: TextField(
                controller: titleController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: 'Bạn đang nghĩ gì?',
                  hintStyle:
                      TextStyle(color: context.theme.colorScheme.primary.withOpacity(0.3), fontWeight: FontWeight.w500, fontSize: 18),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  fillColor: context.theme.colorScheme.secondary,
                  filled: true,
                ),
                style: TextStyle(color: context.theme.colorScheme.primary, fontSize: 18),
                maxLines: null,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              height: 55,
              color: Colors.black12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SvgButton(
                    AppIcons.iconRemove,
                    color: context.theme.colorScheme.error,
                    onTap: () => context.navigator.pop(),
                  ),
                  SvgButton(
                    AppIcons.iconImage,
                    color: context.theme.colorScheme.secondaryContainer,
                    onTap: () => context.navigator.pop(),
                  ),
                  SvgButton(
                    AppIcons.iconVideo,
                    color: context.theme.colorScheme.onPrimaryContainer,
                    onTap: () => context.navigator.pop(),
                  ),
                  SvgButton(
                    AppIcons.iconFiles,
                    color: context.theme.colorScheme.primary,
                    onTap: () => context.navigator.pop(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
