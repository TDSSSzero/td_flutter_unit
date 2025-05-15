import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';
import 'package:td_flutter_unit/pages/settings/settings_page.dart';
import 'package:td_flutter_unit/pages/starter/splash_page.dart';
import 'package:td_flutter_unit/pages/system/404.dart';

List<GoRoute> get globalRoutes => [
  GoRoute(
    path: AppRoute.splash.path,
    builder: (context, state) => SplashPage(),
  ),
  GoRoute(
    path: AppRoute.globalError.path,
    builder: (context, state) => Error404Page(),
  ),
  
];

List<GoRoute> get settingsRoutes => [
  GoRoute(
    path: AppRoute.settings.path,
    builder: (context, state) => SettingsPage(),
  ),

];