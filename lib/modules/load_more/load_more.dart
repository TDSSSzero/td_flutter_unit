import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';
import 'package:td_flutter_unit/pages/home_provider.dart';

class LoadMorePage extends ConsumerWidget {
  const LoadMorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BasePage(
      title: ref.watch(curMenuItemProvider).name,
      child: Column(
        children: [
          ElevatedButton(onPressed: () => context.push(AppRoute.loadMoreList.url),
          child: Text("list"))
        ],
      ));
  }
}