import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/context.dart';
import '../../../common/extensions/date_time.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/widgets/bottom_sheet.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../data/api_firebase/app_provider.dart';
import '../../../data/api_firebase/chat_provider.dart';
import '../../../navigation/navigation.dart';
import 'comment_post_bottom_sheet.dart';
import 'create_post_bottom_sheet.dart';

class Comment {
  final String id;
  final String content;
  final String userId;
  final DateTime createdAt;
  final List<Comment> replies;

  Comment({
    required this.id,
    required this.content,
    required this.userId,
    required this.createdAt,
    this.replies = const [],
  });
}

class DiaryWidget extends StatefulWidget {
  const DiaryWidget({super.key});

  @override
  State<DiaryWidget> createState() => _DiaryWidgetState();
}

class _DiaryWidgetState extends State<DiaryWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      context.read<AppProvider>().getAllPost();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(builder: (context, dataChat, child) {
      return Consumer<AppProvider>(builder: (context, data, child) {
        final posts = data.posts;
        return Expanded(
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            children: [
              GestureDetector(
                onTap: () =>
                    BottomSheetChat.show(context, hasListenerVerticalDrag: true, child: BottomSheetCreatePost(user: dataChat.userProfile)),
                child: Card(
                  shadowColor: context.theme.colorScheme.secondaryContainer,
                  color: context.theme.colorScheme.onPrimary,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(color: context.theme.colorScheme.secondaryContainer.withOpacity(0.4), width: 1),
                                  image: dataChat.userProfile.image.isNotEmpty
                                      ? DecorationImage(image: NetworkImage(dataChat.userProfile.image), fit: BoxFit.fill)
                                      : null),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              'Bạn đang nghĩ gì ...',
                              style: context.textTheme.bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w500, color: context.theme.colorScheme.secondaryContainer),
                            ),
                          ],
                        ),
                        SvgButton(
                          AppIcons.iconImage,
                          color: context.theme.colorScheme.secondaryContainer,
                          size: 20,
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: posts.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final data = dataChat.users;
                  return Card(
                    color: context.theme.colorScheme.onPrimary,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => context.navigator.pushNamed(AppRoutes.profile, arguments: data),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 35,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22),
                                          border: Border.all(color: context.theme.colorScheme.onPrimary.withOpacity(0.4), width: 2),
                                          image: posts[index].user?.image.isNotEmpty == true
                                              ? DecorationImage(image: NetworkImage(posts[index].user!.image), fit: BoxFit.fill)
                                              : null),
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          posts[index].user?.name ?? '',
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(fontWeight: FontWeight.w600, color: context.theme.colorScheme.primary),
                                        ),
                                        const SizedBox(height: 3),
                                        Text(
                                          DateTime.parse(posts[index].createdAt).formattedMinute,
                                          style: context.textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.w500, color: context.theme.colorScheme.primary.withOpacity(0.4)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SvgButton(
                                AppIcons.iconMore,
                                color: context.theme.colorScheme.secondaryContainer,
                                size: 20,
                                onTap: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '   ${posts[index].title}',
                            style: context.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w500, color: context.theme.colorScheme.secondaryContainer),
                          ),
                          const SizedBox(height: 10),
                          posts[index].image.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  height: 200,
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(posts[index].image, fit: BoxFit.fill),
                                  ),
                                )
                              : const SizedBox.shrink(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgButton(
                                    AppIcons.iconMessage,
                                    color: context.theme.colorScheme.secondaryContainer,
                                    size: 24,
                                    onTap: () {
                                      BottomSheetChat.show(context,
                                          hasListenerVerticalDrag: false, child: CommentPostBottomSheet(postEntity: posts[index]));
                                    },
                                  ),
                                  Text(
                                    'Bình luận',
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w500, color: context.theme.colorScheme.secondaryContainer),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    posts[index].message.toString(),
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w500, color: context.theme.colorScheme.primary),
                                  ),
                                  SvgButton(
                                    AppIcons.iconMessage,
                                    color: context.theme.colorScheme.secondaryContainer,
                                    size: 24,
                                    onTap: () {},
                                  ),
                                  Text(
                                    posts[index].like.toString(),
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w500, color: context.theme.colorScheme.primary),
                                  ),
                                  SvgButton(
                                    AppIcons.iconLike,
                                    color: context.theme.colorScheme.secondaryContainer,
                                    onTap: () {},
                                  ),
                                  Text(
                                    posts[index].favorite.toString(),
                                    style: context.textTheme.bodyLarge
                                        ?.copyWith(fontWeight: FontWeight.w500, color: context.theme.colorScheme.primary),
                                  ),
                                  SvgButton(
                                    AppIcons.iconFavorite,
                                    color: context.theme.colorScheme.secondaryContainer,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      });
    });
  }
}
