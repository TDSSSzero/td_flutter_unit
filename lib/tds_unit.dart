import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/cons/str_unit.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';
import 'package:td_flutter_unit/navigation/router/app_router.dart';
import 'package:td_flutter_unit/theme/theme_config.dart';
import 'package:td_flutter_unit/theme/theme_provider.dart';
import 'package:td_flutter_unit/utils/screen_util.dart';

/// author TDSSS
/// datetime 2025/5/12

class TDUnit extends StatefulWidget {
  const TDUnit({super.key});

  @override
  State<TDUnit> createState() => _TDUnitState();
}

class _TDUnitState extends State<TDUnit> {
  final GoRouter _router = GoRouter(
    initialLocation: AppRoute.splash.url,
    routes: [appRoute],
    onException: (BuildContext ctx, GoRouterState state, GoRouter router) {
      router.go(AppRoute.globalError.url, extra: state.uri.toString());
    },
  );

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final themeMode = ref.watch(themeProvider);
        return MaterialApp.router(
          routerConfig: _router,
          title: StrUnit.appName,
          theme: ThemeConfig.lightTheme,
          darkTheme: ThemeConfig.darkTheme,
          themeMode: themeMode,
          builder: (context, child) {
            ScreenUtil.init(width: 750, height: 1334, allowFontScaling: true);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!,
            );
          },
        );
      },
    );
  }
}
