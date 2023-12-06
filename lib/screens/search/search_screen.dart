import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/extensions/context.dart';
import '../../common/resources/app_icon.dart';
import '../../common/widgets/bottom_sheet.dart';
import '../../common/widgets/svg_button.dart';
import '../../data/api_firebase/chat_provider.dart';
import '../../navigation/navigation.dart';
import '../home/component/home_chat_user_bottom_sheet.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _textController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().getSearch('');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, data, child) {
        final usersSearch = data.usersSearch;
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: context.theme.colorScheme.onPrimary,
              body: Stack(
                children: [
                  ListView.builder(
                    itemCount: usersSearch.length,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.only(top: 80),
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: () {
                          context.read<ChatProvider>().setUser(usersSearch[index]);
                          context.navigator.pushNamed(AppRoutes.userChat, arguments: usersSearch[index]);
                        },
                        onLongPress: () {
                          BottomSheetChat.show(
                            context,
                            child: HomeChatUserBottomSheet(
                              onAdd: () {},
                              onCreate: () {},
                              onDelete: () {},
                            ),
                          );
                        },
                        title: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          margin: const EdgeInsets.only(bottom: 30),
                          height: 52,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 12),
                                        width: 52,
                                        height: 52,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(29),
                                        ),
                                        child: ClipOval(
                                          child: Image.network(usersSearch[index].image, fit: BoxFit.fill),
                                        ),
                                      ),
                                      usersSearch[index].isOnline
                                          ? Positioned(
                                              right: 10,
                                              bottom: 0,
                                              child: Container(
                                                height: 14,
                                                width: 14,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.green,
                                                    border: Border.all(width: 2, color: context.theme.colorScheme.onPrimary)),
                                              ),
                                            )
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        usersSearch[index].name,
                                        style: context.textTheme.titleLarge?.copyWith(
                                          color: context.theme.colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        'You: How are you today?',
                                        style: context.textTheme.bodyMedium?.copyWith(
                                          color: context.theme.colorScheme.primary.withOpacity(0.5),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '2 min ago',
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      color: context.theme.colorScheme.primary.withOpacity(0.5),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(right: 1, bottom: 1),
                                    height: 22,
                                    width: 22,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: context.theme.colorScheme.error.withOpacity(0.9),
                                    ),
                                    child: Center(child: Text(index.toString())),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 17),
                    height: 44,
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        suffixIcon: SvgButton(
                          AppIcons.iconRemove,
                          size: 24,
                          onTap: () => context.navigator.pop(),
                        ),
                        prefixIcon: const SvgButton(
                          AppIcons.iconSearch,
                          size: 24,
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        fillColor: context.theme.colorScheme.secondary,
                        filled: true,
                      ),
                      style: TextStyle(color: context.theme.colorScheme.primary),
                      onChanged: (value) {
                        Provider.of<ChatProvider>(context, listen: false).getSearch(value);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
