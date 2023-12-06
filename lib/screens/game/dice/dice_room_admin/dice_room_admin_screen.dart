import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:provider/provider.dart';

import '../../../../common/extensions/context.dart';
import '../../../../common/resources/app_icon.dart';
import '../../../../common/resources/app_image.dart';
import '../../../../common/widgets/svg_button.dart';
import '../../../../data/api_firebase/dice_provider.dart';
import '../../../../models/dice/dice.dart';
import '../../../../models/model_class/money.dart';
import '../../../../navigation/navigation.dart';

class DiceRoomAdminScreen extends StatefulWidget {
  const DiceRoomAdminScreen({super.key, required this.dice});

  final Dice dice;

  @override
  State<DiceRoomAdminScreen> createState() => _DiceRoomAdminScreenState();
}

class _DiceRoomAdminScreenState extends State<DiceRoomAdminScreen> {
  DiceImage? selectedIndex;

  List<DiceImage> diceImages = [
    DiceImage(image: AppImages.imgNai),
    DiceImage(image: AppImages.imgBau),
    DiceImage(image: AppImages.imgGa),
    DiceImage(image: AppImages.imgCa),
    DiceImage(image: AppImages.imgCua),
    DiceImage(image: AppImages.imgTom),
  ];

  @override
  Widget build(BuildContext context) {
    List<DiceImage> getRandomElements() {
      List<DiceImage> resultList = [];
      List<DiceImage> tempList = List.from(diceImages);
      Random random = Random();

      for (int i = 0; i < 3; i++) {
        int randomIndex = random.nextInt(tempList.length);
        resultList.add(tempList[randomIndex]);
      }

      return resultList;
    }

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF630809), Color(0xFF7B0B09), Color(0xFFB51409), Color(0xFFB51409), Color(0xFF7B0B09), Color(0xFF630809)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
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
                          image: DecorationImage(image: NetworkImage(widget.dice.adminAvatar), fit: BoxFit.fill),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.dice.roomName,
                            maxLines: 1,
                            style: TextStyle(
                                color: context.theme.colorScheme.onPrimary, fontWeight: FontWeight.w800, fontSize: 20, letterSpacing: 1),
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              SvgButton(
                                AppIcons.iconUser,
                                color: context.theme.colorScheme.onPrimary.withOpacity(0.8),
                                size: 18,
                              ),
                              const SizedBox(width: 3),
                              Text(
                                widget.dice.adminName,
                                maxLines: 1,
                                style: TextStyle(
                                    color: context.theme.colorScheme.onPrimary.withOpacity(0.8), fontWeight: FontWeight.w400, fontSize: 15),
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
                    decoration: BoxDecoration(
                      color: context.theme.colorScheme.onPrimary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: SvgButton(
                      AppIcons.iconRemove,
                      color: context.theme.colorScheme.onPrimaryContainer,
                      size: 35,
                      onTap: () async {
                        await context.read<DiceProvider>().deleteRoom(idRoom: widget.dice.id);
                        if (context.mounted) context.navigator.popUntil((route) => route.settings.name == AppRoutes.dice);
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.white,
                      border: Border.all(color: Colors.red),
                    ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 200,
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: getRandomElements().map((item) {
                        return Container(
                          height: 110,
                          width: 80,
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.red),
                            image: DecorationImage(image: AssetImage(item.image), fit: BoxFit.fill),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: SizedBox(
                width: 100,
                child: GFButton(
                  size: 40,
                  text: 'Sốc',
                  textStyle:
                      TextStyle(fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 0.2, color: context.theme.colorScheme.primary),
                  borderShape: const StadiumBorder(),
                  color: context.theme.colorScheme.onPrimaryContainer,
                  blockButton: true,
                  onPressed: () {
                    setState(() {
                      getRandomElements();
                    });
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0), child: Divider(color: context.theme.colorScheme.onPrimary)),
            Expanded(
              child: Consumer<DiceProvider>(
                builder: (context, data, child) {
                  final roomUsers = data.dices;
                  return ListView.builder(
                    itemCount: roomUsers.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 12),
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(29),
                                          image: DecorationImage(image: NetworkImage(roomUsers[index].adminAvatar), fit: BoxFit.fill),
                                        ),
                                      ),
                                      Text(roomUsers[index].adminName)
                                    ],
                                  ),
                                  SvgButton(
                                    AppIcons.iconMore,
                                    color: context.theme.colorScheme.onPrimary,
                                    size: 18,
                                    onTap: () {},
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 72,
                              child: ListView.builder(
                                itemCount: 6,
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 70,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(16),
                                            border: Border.all(color: Colors.red),
                                            image: DecorationImage(image: AssetImage(diceImages[index].image), fit: BoxFit.fill),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text('$index Trieu')
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(padding: const EdgeInsets.only(left: 16.0), child: Divider(color: context.theme.colorScheme.onPrimary)),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
