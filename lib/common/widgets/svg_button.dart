import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../extensions/context.dart';

class SvgButton extends StatelessWidget {
  const SvgButton(
    this.assetName, {
    Key? key,
    this.color,
    this.size,
    this.padding = const EdgeInsets.all(1),
    this.onTap,
  }) : super(key: key);
  final String assetName;
  final Color? color;
  final double? size;
  final EdgeInsets padding;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return onTap != null
        ? IconButton(
            onPressed: () => onTap?.call(),
            padding: padding,
            iconSize: size ?? 24,
            icon: SvgPicture.asset(
              assetName,
              height: size,
              width: size,
              color: color ?? context.theme.colorScheme.primary,
              fit: BoxFit.scaleDown,
            ),
          )
        : Padding(
            padding: padding,
            child: SvgPicture.asset(
              assetName,
              color: color ?? context.theme.colorScheme.primary,
              height: size ?? 24,
              width: size ?? 24,
              fit: BoxFit.scaleDown,
            ),
          );
  }
}
