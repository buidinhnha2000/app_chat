import 'package:flutter/material.dart';

import '../../../common/extensions/context.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/resources/app_image.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../models/model_class/model_topic_message.dart';

class BottomSheetTopicMessage extends StatelessWidget {
  const BottomSheetTopicMessage({super.key, this.onTopic, this.onDeleteTopic});

  final ValueChanged<int>? onTopic;
  final VoidCallback? onDeleteTopic;

  @override
  Widget build(BuildContext context) {
    List<ModelTopicMessage> topicMessages = [
      ModelTopicMessage(image: AppImages.topic1, title: 'Topic 1'),
      ModelTopicMessage(image: AppImages.topic2, title: 'Topic 2'),
      ModelTopicMessage(image: AppImages.topic3, title: 'Topic 3'),
      ModelTopicMessage(image: AppImages.topic4, title: 'Topic 4'),
    ];
    return Container(
      height: 300,
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 16, bottom: 10),
              height: 3,
              width: 30,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: context.theme.colorScheme.primary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
            child: Text(
              'Selected Topic',
              style: context.textTheme.titleLarge?.copyWith(color: Colors.green, fontWeight: FontWeight.w600),
            ),
          ),
          Divider(height: 10, color: context.theme.colorScheme.primary.withOpacity(0.3), indent: 5),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                  onTap: () => onDeleteTopic?.call(),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 44,
                            height: 44,
                            child: SvgButton(AppIcons.iconRemove, color: context.theme.colorScheme.error),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Delete topic message',
                            style: context.textTheme.titleMedium
                                ?.copyWith(color: context.theme.colorScheme.primary, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Divider(height: 10, color: context.theme.colorScheme.primary.withOpacity(0.3), indent: 55)
                    ],
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: topicMessages.length,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(0),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                      onTap: () => onTopic?.call((index + 1)),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  border: Border.all(color: context.theme.colorScheme.onPrimary.withOpacity(0.4), width: 2),
                                ),
                                child: ClipOval(
                                  child: Image.asset(topicMessages[index].image, fit: BoxFit.fill),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                topicMessages[index].title,
                                style: context.textTheme.titleMedium
                                    ?.copyWith(color: context.theme.colorScheme.primary, fontWeight: FontWeight.w600),
                              )
                            ],
                          ),
                          Divider(height: 10, color: context.theme.colorScheme.primary.withOpacity(0.3), indent: 55)
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
