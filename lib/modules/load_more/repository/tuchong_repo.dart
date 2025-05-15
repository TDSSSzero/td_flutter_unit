import 'dart:convert';

// import 'package:dio/dio.dart';
import 'package:http_client_helper/http_client_helper.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:td_flutter_unit/modules/load_more/repository/tuchong_source.dart';

class TuChongRepository extends LoadingMoreBase<TuChongItem>{

  int _pageIndex = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  @override
  bool get hasMore => (_hasMore && length < 30) || forceRefresh;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = true;
    _pageIndex = 1;
    //force to refresh list when you don't want clear list before request
    //for the case, if your list already has 20 items.
    forceRefresh = !clearBeforeRequest;
    var result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    String url = '';
    if (isEmpty) {
      url = 'https://api.tuchong.com/feed-app';
    } else {
      final int? lastPostId = this[length - 1].postId;
      url =
          'https://api.tuchong.com/feed-app?post_id=$lastPostId&page=$_pageIndex&type=loadmore';
    }
    bool isSuccess = false;
    try {
      //to show loading more clearly, in your app,remove this
      await Future<void>.delayed(const Duration(seconds: 2));
      List<TuChongItem>? feedList;
      
        final Response result =
            await HttpClientHelper.get(Uri.parse(url)) as Response;
        feedList = TuChongSource.fromJson(
                json.decode(result.body) as Map<String, dynamic>)
            .feedList;

      if (_pageIndex == 1) {
        clear();
      }

      for (final TuChongItem item in feedList!) {
        if (item.hasImage && !contains(item) && hasMore) {
          add(item);
        }
      }

      _hasMore = feedList.isNotEmpty;
      _pageIndex++;
      isSuccess = true;
    } catch (exception, stack) {
      isSuccess = false;
      print(exception);
      print(stack);
    }
    return isSuccess;
  }

}