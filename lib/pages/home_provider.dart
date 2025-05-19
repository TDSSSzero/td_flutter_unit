import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:td_flutter_unit/modules/menu_items.dart';
import 'package:td_flutter_unit/navigation/router/app_route.dart';

// Necessary for code-generation to work
part 'home_provider.g.dart';

/// This will create a provider named `activityProvider`
/// which will cache the result of this function.
@riverpod
Future<String> activity(Ref ref) async {
  print("provider");
  // Using package:http, we fetch a random activity from the Bored API.
  final response = await http.get(Uri.https('api.jikan.moe', '/v4/anime/38389'));
  print("provider stattus : ${response.statusCode}");
  if(response.statusCode != 200)
  {
    print("error: ${response.body}");
  }
  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  // final json = jsonDecode(response.body) as Map<String, dynamic>;
  // // Finally, we convert the Map into an Activity instance.
  // final animeList = json['data'] as List;
  return response.body;
}

@riverpod
class CurMenuItem extends _$CurMenuItem {
  @override
  MenuItem build() {
    return MenuItem(route: AppRoute.globalError, name: '404');
  }

  void setItem(MenuItem item) {
    if(state == item)return;
    state = item;
  }
}


@riverpod
class Counter extends _$Counter {
  @override
  int build() {
    return 0;
  }
  void increment(){
    state++;
  }
}