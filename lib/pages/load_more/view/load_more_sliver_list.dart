import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:td_flutter_unit/pages/base/base_page.dart';
import 'package:td_flutter_unit/pages/load_more/repository/tuchong_repo.dart';
import 'package:td_flutter_unit/pages/load_more/repository/tuchong_source.dart';
import 'package:td_flutter_unit/pages/load_more/widget/item_builder.dart';

class LoadMoreSliverListPage extends ConsumerStatefulWidget {
  const LoadMoreSliverListPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoadMoreSliverListPageState();
}

class _LoadMoreSliverListPageState extends ConsumerState<LoadMoreSliverListPage> {
    late TuChongRepository listSourceRepository;
    late TuChongRepository listSourceRepository1;
  @override
  void initState() {
    listSourceRepository = TuChongRepository(maxLength: 20);
    listSourceRepository1 = TuChongRepository(maxLength: 20);
    super.initState();
  }

  @override
  void dispose() {
    listSourceRepository.dispose();
    listSourceRepository1.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BasePage(
    title: 'loadMore sliver list',
    child: LoadingMoreCustomScrollView(
      slivers: <Widget>[
        LoadingMoreSliverList<TuChongItem>(SliverListConfig<TuChongItem>(
        itemBuilder: itemBuilder,
        sourceList: listSourceRepository,
        //isLastOne: false
        //autoRefresh: false,
      )),
      LoadingMoreSliverList(SliverListConfig<TuChongItem>(
        itemBuilder: itemBuilder,
        sourceList: listSourceRepository1,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      ))
      ],
    ));
  }
}