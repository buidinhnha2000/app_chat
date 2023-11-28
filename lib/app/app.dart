import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../common/extensions/context.dart';
import '../data/api_firebase/chat_provider.dart';
import '../l10n/l10n.dart';
import '../navigation/navigation.dart';
import '../theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = context.theme.brightness;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: theme == Brightness.light ? ThemeMode.light : ThemeMode.dark,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      onGenerateRoute: AppNavigation.onGeneratedRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
