import 'package:flutter/material.dart';

import '../../../common/extensions/extensions.dart';

class HomeChatUserBottomSheet extends StatelessWidget {
  const HomeChatUserBottomSheet({super.key, this.onDelete, this.onAdd, this.onCreate});

  final VoidCallback? onDelete;
  final VoidCallback? onAdd;
  final VoidCallback? onCreate;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.all(0),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 16, bottom: 10),
              height: 3,
              width: 30,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: context.theme.colorScheme.background),
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            onTap: () => onAdd?.call(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.add_box_outlined, color: context.theme.colorScheme.background),
                const SizedBox(width: 10),
                Text(
                  'Add',
                  style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.background, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            onTap: () => onCreate?.call(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.create_outlined, color: context.theme.colorScheme.background),
                const SizedBox(width: 10),
                Text(
                  'Create',
                  style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.background, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 24),
            onTap: () => onDelete?.call(),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.delete_outline_outlined, color: context.theme.colorScheme.background),
                const SizedBox(width: 10),
                Text(
                  'Delete',
                  style: context.textTheme.titleMedium?.copyWith(color: context.theme.colorScheme.background, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
