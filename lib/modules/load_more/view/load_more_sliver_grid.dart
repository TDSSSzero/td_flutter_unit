import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';
import 'package:td_flutter_unit/modules/load_more/repository/tuchong_repo.dart';
import 'package:td_flutter_unit/modules/load_more/repository/tuchong_source.dart';
import 'package:td_flutter_unit/modules/load_more/widget/item_builder.dart';

class LoadMoreWaterfallFlowPage extends ConsumerStatefulWidget {
  const LoadMoreWaterfallFlowPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoadMoreWaterfallFlowPageState();
}

class _LoadMoreWaterfallFlowPageState extends ConsumerState<LoadMoreWaterfallFlowPage> {
  
  late TuChongRepository listSourceRepository;
  @override
  void initState() {
    listSourceRepository = TuChongRepository();
    super.initState();
  }

  @override
  void dispose() {
    listSourceRepository.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'loadmore waterfall flow',
      child: LoadingMoreList<TuChongItem>(
        ListConfig<TuChongItem>(
          sourceList: listSourceRepository,
          itemBuilder: buildWaterfallFlowItem,
          extendedListDelegate: const SliverWaterfallFlowDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
             crossAxisSpacing: 5,
              mainAxisSpacing: 5
              ),
          padding: const EdgeInsets.all(5),
          lastChildLayoutType: LastChildLayoutType.foot
        )
      ),
    );
  }
}