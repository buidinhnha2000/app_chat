import 'package:flutter/material.dart';

import '../../common/extensions/extensions.dart';
import '../../common/resources/app_icon.dart';
import '../../common/widgets/svg_button.dart';
import '../../models/arguments/call_argument.dart';
import '../../navigation/navigation.dart';

class CallIncomingScreen extends StatefulWidget {
  const CallIncomingScreen({super.key, required this.callArgument});

  final CallArgument callArgument;

  @override
  State<CallIncomingScreen> createState() => _CallIncomingScreenState();
}

class _CallIncomingScreenState extends State<CallIncomingScreen> {
  late bool isCallVideo;

  @override
  void initState() {
    isCallVideo = widget.callArgument.isCallVideo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Container(
              padding: EdgeInsets.zero,
              child: Image.network(widget.callArgument.user.image, fit: BoxFit.fill, height: double.infinity, width: double.infinity),
            ),
          ),
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12, bottom: 16),
                  child: ClipOval(child: Image.network(widget.callArgument.user.image, fit: BoxFit.fill, height: 126, width: 126)),
                ),
                Text(widget.callArgument.user.name, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white)),
                const SizedBox(height: 8),
                Text('Incoming call', style: TextStyle(fontSize: 15, color: Colors.white.withOpacity(0.8))),
                const SizedBox(height: 200),
                Container(
                  height: 60,
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgButton(
                        AppIcons.iconMessage,
                        color: Colors.white,
                        onTap: () => context.navigator.pop(),
                      ),
                      SvgButton(
                        AppIcons.iconMicrophone,
                        color: Colors.white,
                        onTap: () {
                          context.navigator
                              .pushNamed(AppRoutes.call, arguments: CallArgument(user: widget.callArgument.user, isCallVideo: isCallVideo));
                        },
                      ),
                      SvgButton(
                        AppIcons.iconVideo,
                        color: isCallVideo == true ? context.theme.colorScheme.secondaryContainer : Colors.red.shade700,
                        onTap: () {
                          setState(() {
                            isCallVideo = !isCallVideo;
                          });
                        },
                      ),
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(color: Colors.red.shade700, borderRadius: BorderRadius.circular(22)),
                        child: SvgButton(
                          AppIcons.iconRemove,
                          color: Colors.white,
                          onTap: () => context.navigator.pop(),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          )
        ],
      ),
    );
  }
}
