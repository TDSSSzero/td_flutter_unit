import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/navigation/menu/menu.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';
import 'package:td_flutter_unit/navigation/system/global.dart';
import 'package:td_flutter_unit/pages/home_page.dart';

/// author TDSSS
/// datetime 2025/5/12


RouteBase get appRoute{

  return GoRoute(
    path: AppRoute.home.path,
    routes:[
      ...globalRoutes,
      ...settingsRoutes,
      ...menuRoute,
    ],
    builder: (_,__) => HomePage()
    );
}

