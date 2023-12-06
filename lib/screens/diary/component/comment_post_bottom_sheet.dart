import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/extensions/context.dart';
import '../../../../common/resources/app_icon.dart';
import '../../../../common/widgets/svg_button.dart';
import '../../../data/api_firebase/app_provider.dart';
import '../../../models/comment/comment.dart';
import '../../../models/dtos_entity/post_entity/post_entity.dart';

class CommentPostBottomSheet extends StatelessWidget {
  const CommentPostBottomSheet({super.key, required this.postEntity});

  final PostEntity postEntity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 30),
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 16, bottom: 10),
              child: Text(
                'Bình luận',
                style: TextStyle(color: context.theme.colorScheme.primary, fontSize: 18),
              ),
            ),
          ),
          Divider(height: 10, color: context.theme.colorScheme.primary.withOpacity(0.1), indent: 5, thickness: 1.5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                SvgButton(AppIcons.iconLike, color: context.theme.colorScheme.secondaryContainer),
                const SizedBox(width: 5),
                Text(
                  postEntity.like.toString(),
                  style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, color: context.theme.colorScheme.primary),
                ),
                const SizedBox(width: 5),
                SvgButton(AppIcons.iconFavorite, color: context.theme.colorScheme.error),
                const SizedBox(width: 5),
                Text(
                  postEntity.favorite.toString(),
                  style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, color: context.theme.colorScheme.primary),
                ),
                const SizedBox(width: 5),
                SvgButton(AppIcons.iconLinear, color: context.theme.colorScheme.secondaryContainer),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: CommentWidget(postEntity: postEntity),
          ),
        ],
      ),
    );
  }
}

class CommentWidget extends StatefulWidget {
  const CommentWidget({super.key, required this.postEntity});

  final PostEntity postEntity;

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AppProvider>().getCommentByPost(widget.postEntity.id);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, data, child) {
      final comments = data.comments;
      return ListView.builder(
          itemCount: comments.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 12),
                    child: ClipOval(
                      child: Image.network('comment.image', fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(left: 0),
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.secondary,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                'Nguyễn Huệ',
                                maxLines: null,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                comments[index].title,
                                maxLines: null,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.theme.colorScheme.primary.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '1 Ngày',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    'Thích',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    'Phản hồi',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '111',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 2),
                                  SvgButton(AppIcons.iconFavorite, size: 17, color: context.theme.colorScheme.error),
                                  const SizedBox(width: 2),
                                  SvgButton(AppIcons.iconLike, size: 17, color: context.theme.colorScheme.secondaryContainer),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CommentChildWidget(comment: comments[index]),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }
}

class CommentChildWidget extends StatefulWidget {
  const CommentChildWidget({super.key, this.comment});

  final Comment? comment;

  @override
  State<CommentChildWidget> createState() => _CommentChildWidgetState();
}

class _CommentChildWidgetState extends State<CommentChildWidget> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(widget.comment?.id.isNotEmpty == true) {
        await context.read<AppProvider>().getCommentByComment(widget.comment!.id);
      }
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, data, child) {
        final childComments = data.childComments;
        return ListView.builder(
          itemCount: childComments.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 30,
                    width: 30,
                    margin: const EdgeInsets.only(right: 12),
                    child: ClipOval(
                      child: Image.network('comment.image', fit: BoxFit.fill),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          margin: const EdgeInsets.only(left: 0),
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.secondary,
                            borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nguyễn Huệ',
                                maxLines: null,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                'Hom nay la mot ngay nang dap va gio. Toi di choi',
                                maxLines: null,
                                style: context.textTheme.bodyLarge?.copyWith(
                                  color: context.theme.colorScheme.primary.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '1 Ngày',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    'Thích',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 15),
                                  Text(
                                    'Phản hồi',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    '111',
                                    style: context.textTheme.bodyMedium
                                        ?.copyWith(color: context.theme.colorScheme.primary.withOpacity(0.6), fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 2),
                                  SvgButton(AppIcons.iconFavorite, size: 17, color: context.theme.colorScheme.error),
                                  const SizedBox(width: 2),
                                  SvgButton(AppIcons.iconLike, size: 17, color: context.theme.colorScheme.secondaryContainer),
                                ],
                              ),
                            ],
                          ),
                        ),
                        // CommentChildWidget(),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        );
      }
    );
  }
}
