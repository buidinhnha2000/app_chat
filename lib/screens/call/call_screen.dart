import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/context.dart';
import '../../common/resources/app_icon.dart';
import '../../common/widgets/svg_button.dart';
import '../../data/api_firebase/chat_provider.dart';
import '../../models/arguments/call_argument.dart';
import '../../navigation/navigation.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key, required this.callArgument});

  final CallArgument callArgument;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool showCamera = false;
  bool showCameraBefore = true;
  late List<CameraDescription> _cameras;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _cameras = await availableCameras();
      if (widget.callArgument.isCallVideo == true) {
        showCamera = true;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, data, child) {
        final you = data.userProfile;
        return Scaffold(
          body: Stack(
            children: [
              widget.callArgument.isCallVideo == true
                  ? const SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    )
                  : Image.network(
                      widget.callArgument.user.image,
                      fit: BoxFit.fill,
                      height: double.infinity,
                      width: double.infinity,
                    ),
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.transparent, Colors.transparent, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    tileMode: TileMode.mirror,
                  ),
                ),
                padding: EdgeInsets.zero,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 44,
                          width: 44,
                          decoration:
                              BoxDecoration(color: context.theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(22)),
                          child: SvgButton(
                            AppIcons.iconVolume,
                            color: Colors.white,
                            onTap: () {},
                          ),
                        ),
                        Container(
                          height: 44,
                          width: 44,
                          decoration:
                              BoxDecoration(color: context.theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(22)),
                          child: SvgButton(
                            AppIcons.iconVideo,
                            color: Colors.white,
                            onTap: () {
                              setState(() {
                                showCamera = !showCamera;
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 44,
                          width: 44,
                          decoration:
                              BoxDecoration(color: context.theme.colorScheme.primaryContainer, borderRadius: BorderRadius.circular(22)),
                          child: SvgButton(
                            AppIcons.iconMicrophone,
                            color: Colors.white,
                            onTap: () {},
                          ),
                        ),
                        Container(
                          height: 44,
                          width: 44,
                          decoration:
                              BoxDecoration(color: context.theme.colorScheme.secondaryContainer, borderRadius: BorderRadius.circular(22)),
                          child: SvgButton(
                            AppIcons.iconMessage,
                            color: Colors.white,
                            onTap: () => context.navigator.popUntil((route) => route.settings.name == AppRoutes.userChat),
                          ),
                        ),
                        Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(color: Colors.red.shade700, borderRadius: BorderRadius.circular(22)),
                          child: SvgButton(
                            AppIcons.iconRemove,
                            color: Colors.white,
                            onTap: () => context.navigator.popUntil((route) => route.settings.name == AppRoutes.userChat),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 70,
                left: 20,
                child: SvgButton(
                  AppIcons.iconBack,
                  color: Colors.white,
                  onTap: () => context.navigator.popUntil((route) => route.settings.name == AppRoutes.userChat),
                ),
              ),
              Positioned(
                top: 80,
                right: 20,
                child: Container(
                  height: 108,
                  width: 86,
                  decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: BorderRadius.circular(12)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: showCamera == true ? CameraWidget(cameras: _cameras) : Image.network(you.image, fit: BoxFit.fill),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class CameraWidget extends StatefulWidget {
  const CameraWidget({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  State<CameraWidget> createState() => _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        height: 10,
        width: 10,
      );
    }
    return CameraPreview(controller);
  }
}
