import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/extensions/context.dart';
import '../../../data/api_firebase/dice_provider.dart';
import '../../../models/user/user.dart';
import 'component/dice_app_bar.dart';
import 'component/dice_body.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key, required this.user});
  final ChatUser user;
  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DiceProvider>(
      builder: (context, dataChat, child) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: WillPopScope(
              onWillPop: () {
                return Future.value(true);
              },
              child: Scaffold(
                backgroundColor: context.theme.colorScheme.background,
                body: Column(
                  children: [
                    DiceAppBar(user: widget.user),
                    DiceBody(user: widget.user),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
