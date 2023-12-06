import 'dart:math';

import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';

import '../../../../common/extensions/context.dart';
import '../../../../common/resources/app_icon.dart';
import '../../../../common/resources/app_image.dart';
import '../../../../common/widgets/svg_button.dart';
import '../../../../models/dice/dice.dart';
import '../../../../models/model_class/money.dart';

class DiceRoomScreen extends StatefulWidget {
  const DiceRoomScreen({super.key, required this.dice});

  final Dice dice;

  @override
  State<DiceRoomScreen> createState() => _DiceRoomScreenState();
}

class _DiceRoomScreenState extends State<DiceRoomScreen> {
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
    final List<Money> moneys = [
      Money(price: 1, unit: 'nghìn'),
      Money(price: 2, unit: 'nghìn'),
      Money(price: 5, unit: 'nghìn'),
      Money(price: 10, unit: 'nghìn'),
      Money(price: 20, unit: 'nghìn'),
      Money(price: 50, unit: 'nghìn'),
      Money(price: 100, unit: 'nghìn'),
      Money(price: 1, unit: 'triệu'),
      Money(price: 2, unit: 'triệu'),
      Money(price: 5, unit: 'triệu'),
      Money(price: 10, unit: 'triệu'),
      Money(price: 50, unit: 'triệu'),
      Money(price: 100, unit: 'triệu'),
      Money(price: 1, unit: 'tỷ'),
      Money(price: 2, unit: 'tỷ'),
      Money(price: 5, unit: 'tỷ'),
      Money(price: 10, unit: 'tỷ'),
      Money(price: 100, unit: 'tỷ'),
    ];

    int onUnit(String unit, int price) {
      switch (unit) {
        case 'nghìn':
          return price * 1000;
        case 'triệu':
          return price * 1000000;
        case 'tỷ':
          return price * 1000000000;
      }
      return 0;
    }

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
                          color: context.theme.colorScheme.onPrimary.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: SvgButton(
                          AppIcons.iconHome,
                          color: context.theme.colorScheme.onPrimaryContainer,
                          size: 35,
                          onTap: () => context.navigator.pop(),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(widget.dice.roomName,
                              maxLines: 1,
                              style: TextStyle(
                                  color: context.theme.colorScheme.onPrimary, fontWeight: FontWeight.w800, fontSize: 20, letterSpacing: 1)),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              SvgButton(AppIcons.iconUser, color: context.theme.colorScheme.onPrimary.withOpacity(0.8), size: 18,),
                              const SizedBox(width: 3),
                              Text(widget.dice.adminName,
                                  maxLines: 1,
                                  style: TextStyle(color: context.theme.colorScheme.onPrimary.withOpacity(0.8), fontWeight: FontWeight.w400, fontSize: 15)),
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
                      onTap: () => context.navigator.pop(),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        getRandomElements();
                      });
                    },
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                              border: Border.all(color: context.theme.colorScheme.error),
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
                                    border: Border.all(color: context.theme.colorScheme.secondaryContainer),
                                    image: DecorationImage(
                                      image: AssetImage(item.image),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 40,
              child: ListView.builder(
                itemCount: moneys.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Container(
                    width: 100,
                    padding: const EdgeInsets.only(left: 5),
                    child: GFButton(
                      size: 40,
                      text: '${moneys[index].price} ${moneys[index].unit}',
                      textStyle: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 0.2, color: context.theme.colorScheme.onPrimary),
                      borderShape: const StadiumBorder(),
                      color: context.theme.colorScheme.secondaryContainer,
                      blockButton: true,
                      onPressed: () {
                        setState(() {
                          selectedIndex?.price = moneys[index].price * onUnit(moneys[index].unit, moneys[index].price);
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 280,
              width: double.infinity,
              child: GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                children: List.generate(diceImages.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = diceImages[index];
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.red),
                        image: DecorationImage(image: AssetImage(diceImages[index].image), fit: BoxFit.fill),
                      ),
                      child: diceImages[index].price != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  height: 20,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      color: context.theme.colorScheme.onPrimaryContainer, borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      '${diceImages[index].price}',
                                      maxLines: 1,
                                      style: TextStyle(color: context.theme.colorScheme.secondaryContainer, fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : const SizedBox.shrink(),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
