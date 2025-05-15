import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:td_flutter_unit/modules/base/base_page.dart';
import 'package:td_flutter_unit/modules/load_more/repository/tuchong_source.dart';
import 'package:td_flutter_unit/modules/load_more/repository/tuchong_repo.dart';
import 'package:td_flutter_unit/modules/load_more/widget/item_builder.dart';

class LoadMoreListPage extends ConsumerStatefulWidget {
  const LoadMoreListPage({super.key});

  @override
  ConsumerState<LoadMoreListPage> createState() => _LoadMoreListPageState();
}

class _LoadMoreListPageState extends ConsumerState<LoadMoreListPage> {
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
    return BasePage(title: 'load more list demo',child: Center(
      child: 
      // Text("data")
    LoadingMoreList<TuChongItem>(
      ListConfig<TuChongItem>(
        sourceList: _repository,
      itemBuilder: itemBuilder,
        ),
      ),
      ));
  }

}