import 'user_chat_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/context.dart';
import '../../../common/extensions/date_time.dart';
import '../../../common/resources/app_icon.dart';
import '../../../common/widgets/bottom_sheet.dart';
import '../../../common/widgets/svg_button.dart';
import '../../../data/api_firebase/chat_provider.dart';
import '../../../models/message/message.dart';
import '../../../models/user/user.dart';

class UserChatSend extends StatefulWidget {
  const UserChatSend({super.key, required this.user, required this.focusNode});

  final ChatUser user;
  final FocusNode focusNode;

  @override
  State<UserChatSend> createState() => _UserChatSendState();
}

class _UserChatSendState extends State<UserChatSend> {
  final TextEditingController _textController = TextEditingController();
  List<XFile> images = [];

  Future<void> _pickImage(BuildContext context, Function(List<XFile> image) onSuccess) async {
    final picker = ImagePicker();
    final image = await picker.pickMultiImage(imageQuality: 100);
    if (image.isNotEmpty) {
      onSuccess.call(image);
    }
  }

  Future<void> _takeImage(BuildContext context, Function(XFile image) onSuccess) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      onSuccess.call(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Divider(color: context.theme.colorScheme.secondary.withOpacity(0.6), thickness: 2, height: 0),
        Container(
          height: 70,
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0),
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                SvgButton(
                  AppIcons.iconGiff,
                  color: context.theme.colorScheme.primary,
                  onTap: () => BottomSheetChat.show(
                    context,
                    child: BottomSheetTopicMessage(
                      onTopic: (value) {
                        context.read<ChatProvider>().setTopicMessage('1', widget.user.id, value);
                        context.navigator.pop();
                      },
                      onDeleteTopic: () {
                        context.read<ChatProvider>().deleteTopicMessage();
                        context.navigator.pop();
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      controller: _textController,
                      focusNode: widget.focusNode,
                      decoration: InputDecoration(
                        suffixIcon: SvgButton(
                          AppIcons.iconFiles,
                          size: 24,
                          onTap: () async {
                            _pickImage(context, (images) => images);
                          },
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        fillColor: context.theme.colorScheme.secondary,
                        filled: true,
                      ),
                      style: TextStyle(color: context.theme.colorScheme.primary),
                    ),
                  ),
                ),
                SvgButton(
                  AppIcons.iconCamera,
                  size: 24,
                  color: context.theme.colorScheme.primary,
                  onTap: () {
                    widget.focusNode.unfocus();
                    _takeImage(context, (image) => image);
                  },
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: _textController.text.isNotEmpty
                          ? context.theme.colorScheme.secondaryContainer
                          : context.theme.colorScheme.onSecondaryContainer.withOpacity(0.3)),
                  child: SvgButton(
                    AppIcons.iconSend,
                    color: Colors.white,
                    size: 24,
                    onTap: _textController.text.isNotEmpty
                        ? () {
                            final time = DateTime.now().formattedFull;
                            Provider.of<ChatProvider>(context, listen: false).sendMessage(
                              msg: _textController.text,
                              dateTime: time,
                              userId: widget.user.id,
                              typeMessage: TypeMessage.text,
                            );
                            _textController.text = '';
                            widget.focusNode.unfocus();
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
