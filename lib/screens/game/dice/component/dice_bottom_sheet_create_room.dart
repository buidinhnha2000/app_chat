import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/extensions/context.dart';
import '../../../../common/resources/app_icon.dart';
import '../../../../common/widgets/svg_button.dart';
import '../../../../data/api_firebase/dice_provider.dart';
import '../../../../models/dice/dice.dart';
import '../../../../models/user/user.dart';
import '../../../../navigation/navigation.dart';

class BottomSheetDiceCreateRoom extends StatelessWidget {
  const BottomSheetDiceCreateRoom({super.key, required this.user});

  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    final TextEditingController codeRoomController = TextEditingController();
    final TextEditingController nameRoomController = TextEditingController();
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 20, left: 24, right: 24),
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
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 40,
              child: TextField(
                controller: nameRoomController,
                autofocus: true,
                decoration: InputDecoration(
                  suffixIcon: SvgButton(AppIcons.iconRemove, size: 24, onTap: () => nameRoomController.text = ''),
                  prefixIcon: const SvgButton(
                    AppIcons.iconHome,
                  ),
                  hintText: 'Room name',
                  hintStyle:
                      TextStyle(color: context.theme.colorScheme.primary.withOpacity(0.3), fontWeight: FontWeight.w500, fontSize: 15),
                  contentPadding: const EdgeInsets.only(left: 10, top: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  fillColor: context.theme.colorScheme.secondary,
                  filled: true,
                ),
                style: TextStyle(color: context.theme.colorScheme.primary),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              height: 40,
              child: TextField(
                controller: codeRoomController,
                decoration: InputDecoration(
                  suffixIcon: SvgButton(
                    AppIcons.iconRemove,
                    size: 24,
                    onTap: () => codeRoomController.text = '',
                  ),
                  prefixIcon: const SvgButton(AppIcons.iconGiff),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  fillColor: context.theme.colorScheme.secondary,
                  filled: true,
                  hintText: 'Code',
                  hintStyle:
                      TextStyle(color: context.theme.colorScheme.primary.withOpacity(0.3), fontWeight: FontWeight.w500, fontSize: 15),
                ),
                style: TextStyle(color: context.theme.colorScheme.primary),
              ),
            ),
            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GFButton(
                        size: 50,
                        text: 'Join',
                        textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                          color: context.theme.colorScheme.primary,
                        ),
                        borderShape: const StadiumBorder(),
                        color: context.theme.colorScheme.onPrimaryContainer,
                        blockButton: true,
                        onPressed: () {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GFButton(
                        size: 50,
                        text: 'Create',
                        textStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.2,
                          color: context.theme.colorScheme.onPrimary,
                        ),
                        borderShape: const StadiumBorder(),
                        color: context.theme.colorScheme.secondaryContainer,
                        blockButton: true,
                        onPressed: () async {
                          final diceRoom = Dice(
                              id: const Uuid().v4(),
                              roomName: nameRoomController.text,
                              roomId: codeRoomController.text,
                              adminId: user.id,
                              adminName: user.name,
                              adminAvatar: user.image);
                          await context.read<DiceProvider>().createRoom(dice: diceRoom);
                          if (context.mounted) {
                            FocusScope.of(context).unfocus();
                            context.navigator.pushNamed(AppRoutes.diceRoomAdmin, arguments: diceRoom);
                          }
                        },
                      ),
                    ),
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
