import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/extensions/context.dart';
import '../../../../common/resources/app_icon.dart';
import '../../../../common/widgets/bottom_sheet.dart';
import '../../../../common/widgets/svg_button.dart';
import '../../../../data/api_firebase/dice_provider.dart';
import '../../../../models/user/user.dart';
import '../../../../navigation/navigation.dart';
import 'dice_bottom_sheet_create_room.dart';

class DiceBody extends StatefulWidget {
  const DiceBody({super.key, required this.user});

  final ChatUser user;

  @override
  State<DiceBody> createState() => _DiceBodyState();
}

class _DiceBodyState extends State<DiceBody> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<DiceProvider>().getAllDice();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => BottomSheetChat.show(context, child: BottomSheetDiceCreateRoom(user: widget.user)),
              child: Card(
                shadowColor: context.theme.colorScheme.onPrimaryContainer,
                color: context.theme.colorScheme.secondaryContainer,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: context.theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                margin: const EdgeInsets.only(bottom: 10),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'CREATE NEW ROOM',
                            style: context.textTheme.bodyLarge
                                ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.onPrimaryContainer),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              SvgButton(AppIcons.iconHome, color: context.theme.colorScheme.onPrimary),
                              const SizedBox(width: 5),
                              Text(
                                'Create a new room',
                                style: context.textTheme.bodyMedium
                                    ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.onPrimary),
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          SvgButton(AppIcons.iconUser, size: 50, color: context.theme.colorScheme.onPrimaryContainer),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join the room',
                    style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.primary),
                  ),
                  Divider(
                    height: 20,
                    color: context.theme.colorScheme.primary,
                  )
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: context.read<DiceProvider>().getAllDice(),
                builder: (context, snapshot) {
                  return Consumer<DiceProvider>(builder: (context, data, child) {
                    final dices = data.dices;
                    return ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: dices.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () => context.navigator.pushNamed(AppRoutes.diceRoom, arguments: dices[index]),
                            child: Card(
                              shadowColor: context.theme.colorScheme.secondaryContainer,
                              color: context.theme.colorScheme.onPrimaryContainer,
                              shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: context.theme.colorScheme.onPrimaryContainer,
                                ),
                              ),
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          dices[index].roomName,
                                          style: context.textTheme.bodyLarge
                                              ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.secondaryContainer),
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(right: 12),
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(29),
                                              ),
                                              child: ClipOval(
                                                child: Image.network(dices[index].adminAvatar, fit: BoxFit.fill),
                                              ),
                                            ),
                                            Text(
                                              dices[index].adminName,
                                              style: context.textTheme.bodyMedium
                                                  ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.primary),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '$index / 10',
                                          style: context.textTheme.bodyMedium
                                              ?.copyWith(fontWeight: FontWeight.w800, color: context.theme.colorScheme.primary),
                                        ),
                                        SvgButton(AppIcons.iconUser, size: 50, color: context.theme.colorScheme.secondaryContainer),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  });
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
