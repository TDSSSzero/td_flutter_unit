import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/modules/load_more/load_more.dart';
import 'package:td_flutter_unit/modules/load_more/view/load_more_grid.dart';
import 'package:td_flutter_unit/modules/load_more/view/load_more_list.dart';
import 'package:td_flutter_unit/modules/load_more/view/load_more_sliver_grid.dart';
import 'package:td_flutter_unit/modules/load_more/view/load_more_sliver_list.dart';
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
      GoRoute(path: AppRoute.loadMoreGrid.path,builder: (context, state) => LoadMoreGridPage(),),
      GoRoute(path: AppRoute.loadMoreSliverList.path,builder: (context, state) => LoadMoreSliverListPage()),
      GoRoute(path: AppRoute.loadMoreSliverGrid.path,builder: (context, state) => LoadMoreSliverGridPage()),
    ],
  ),
  
      
];
