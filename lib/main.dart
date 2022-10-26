import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/controllers/app_state_controller.dart';
import 'app/controllers/favorite_quotes_controller.dart';
import 'app/controllers/quotes_controller.dart';
import 'router/app_router.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const QuotesApp());
}

class QuotesApp extends StatefulWidget {
  const QuotesApp({Key? key}) : super(key: key);

  @override
  _QuotesAppState createState() => _QuotesAppState();
}

class _QuotesAppState extends State<QuotesApp> {
  final _appStateController = AppStateController();
  final _quotesController = QuotesController();
  final _favoriteQuotesController = FavoriteQuotesController();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateController: _appStateController,
      quotesController: _quotesController,
      favoriteQuotesController: _favoriteQuotesController,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _appStateController),
        ChangeNotifierProvider(create: (context) => _quotesController),
        ChangeNotifierProvider(create: (context) => _favoriteQuotesController)
      ],
      child: MaterialApp(
        title: 'Quotes App',
        theme: AppTheme.lightTheme,
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
