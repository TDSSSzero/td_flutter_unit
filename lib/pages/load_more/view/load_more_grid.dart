import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:td_flutter_unit/pages/base/base_page.dart';
import 'package:td_flutter_unit/pages/load_more/repository/tuchong_repo.dart';
import 'package:td_flutter_unit/pages/load_more/repository/tuchong_source.dart';
import 'package:td_flutter_unit/pages/load_more/widget/item_builder.dart';

class LoadMoreGridPage extends ConsumerStatefulWidget {
  const LoadMoreGridPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoadMoreGridPageState();
}

class _LoadMoreGridPageState extends ConsumerState<LoadMoreGridPage> {

  late TuChongRepository _repository;
  @override
  void initState() {
    _repository = TuChongRepository();
    super.initState();
  }

  @override
  void dispose() {
    _repository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'load more grid',
      child: Center(
        child: LoadingMoreList<TuChongItem>(
          ListConfig<TuChongItem>(
            sourceList: _repository,
            itemBuilder: itemBuilder,
            physics: const FixedOverscrollBouncingScrollPhysics(),
            padding: const EdgeInsets.all(0.0),
            lastChildLayoutType: LastChildLayoutType.foot,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0,
          crossAxisSpacing: 3.0,
          mainAxisSpacing: 3.0,
        ),
          ),
        ),
      ));
  }
}