import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/modules/load_more/load_more.dart';
import 'package:td_flutter_unit/modules/load_more/view/load_more_list.dart';
import 'package:td_flutter_unit/modules/lottie/lottie.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';

List<GoRoute> menuRoute = [
  GoRoute(
    path: AppRoute.lottie.path,
    builder: (context, state) => LottiePage(),
  ),
  GoRoute(
    path: AppRoute.loadMore.path,
    builder: (context, state) => LoadMorePage(),
    routes: [
      GoRoute(
        path: AppRoute.loadMoreList.path,
        builder: (context, state) => LoadMoreListPage(),
      ),
    ],
  ),
  
      
];
