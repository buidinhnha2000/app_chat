import 'dart:math';
import 'package:provider/provider.dart';

import '../../../data/api_firebase/chat_provider.dart';
import '../../../models/user/user.dart';
import '../../../common/widgets/circle_border_with_color.dart';
import 'package:flutter/material.dart';

import '../../../common/extensions/context.dart';
import '../../../navigation/navigation.dart';

class HomeChatHorizontal extends StatelessWidget {
  const HomeChatHorizontal({super.key, required this.users, required this.user});

  final List<ChatUser> users;
  final ChatUser user;

  @override
  Widget build(BuildContext context) {
    final colorBorder = [
      Colors.red,
      Colors.orange,
      Colors.amber,
      Colors.limeAccent,
      Colors.brown,
      Colors.blue,
      Colors.deepPurple,
      Colors.pinkAccent,
      Colors.blueGrey,
      Colors.green,
      Colors.greenAccent,
      Colors.teal,
    ];

    Color getRandomColor() {
      Random random = Random();
      int index = random.nextInt(colorBorder.length);
      return colorBorder[index];
    }

    final colorMy = getRandomColor();
    return SizedBox(
      height: 82,
      child: ListView(
        padding: const EdgeInsets.only(top: 1),
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          Container(
            height: 82,
            width: 62,
            margin: const EdgeInsets.only(left: 24, right: 13),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 58,
                  height: 58,
                  child: Stack(
                    children: [
                      CustomPaint(
                        painter: CircleBorderWith4Color(
                          gap: 4,
                          borderThinckNess: 1,
                          bottomLeftColor: context.theme.colorScheme.onPrimary,
                          bottomRightColor: context.theme.colorScheme.onPrimary,
                          topLeftColor: colorMy,
                          topRightColor: context.theme.colorScheme.onPrimary,
                        ),
                        child: Center(
                          child: Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(29),
                            ),
                            child: ClipOval(
                              child: Image.network(user.image, fit: BoxFit.fill),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.theme.colorScheme.onPrimary),
                          child: Center(
                            child: Icon(Icons.add, size: 12, color: colorMy),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  'My status',
                  style: TextStyle(color: colorMy, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 82,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: users.length,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final colorCircle = getRandomColor();
                return GestureDetector(
                  onTap: () {
                    context.read<ChatProvider>().setUser(users[index]);
                    context.navigator.pushNamed(AppRoutes.userChat, arguments: users[index]);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 13),
                    width: 58,
                    height: 82,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 58,
                          height: 58,
                          child: CustomPaint(
                            painter: CircleBorderWith4Color(
                              gap: 2,
                              borderThinckNess: 1,
                              bottomLeftColor: colorCircle,
                              bottomRightColor: colorCircle,
                              topLeftColor: colorCircle,
                              topRightColor: colorCircle,
                            ),
                            child: Center(
                              child: Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(29),
                                ),
                                child: ClipOval(
                                  child: Image.network(users[index].image, fit: BoxFit.fill),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Text(users[index].name, overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(color: context.theme.colorScheme.onPrimary),),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
